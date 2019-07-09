Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0BF4A63018
	for <lists+linux-nfs@lfdr.de>; Tue,  9 Jul 2019 07:41:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725948AbfGIFk6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 9 Jul 2019 01:40:58 -0400
Received: from smtprelay0142.hostedemail.com ([216.40.44.142]:56051 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727230AbfGIFkz (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 9 Jul 2019 01:40:55 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 1F860181D341A;
        Tue,  9 Jul 2019 05:40:54 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::,RULES_HIT:41:355:379:599:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2553:2559:2562:2693:2828:3138:3139:3140:3141:3142:3353:3622:3865:3866:3867:3868:3871:3872:3873:3874:4321:5007:6119:7903:8603:10004:10400:10450:10455:10848:11026:11232:11473:11658:11914:12043:12297:12555:12740:12760:12895:13019:13069:13138:13141:13161:13229:13230:13231:13311:13357:13439:14659:14721:19904:19999:21080:21433:21451:21627:21819:30012:30029:30054:30090:30091,0,RBL:23.242.196.136:@perches.com:.lbl8.mailshell.net-62.14.0.180 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:24,LUA_SUMMARY:none
X-HE-Tag: bag59_7c29b583d1004
X-Filterd-Recvd-Size: 2614
Received: from XPS-9350 (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf15.hostedemail.com (Postfix) with ESMTPA;
        Tue,  9 Jul 2019 05:40:53 +0000 (UTC)
Message-ID: <9a5dedb0c9221743033f28974820e8dd724e388d.camel@perches.com>
Subject: Re: [PATCH 8/8] nfsd: Fix misuse of strlcpy
From:   Joe Perches <joe@perches.com>
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 08 Jul 2019 22:40:50 -0700
In-Reply-To: <20190709031404.GD14439@fieldses.org>
References: <cover.1562283944.git.joe@perches.com>
         <b51141d12de77eb22101e81f9eb2c9cc44104d7a.1562283944.git.joe@perches.com>
         <20190709031404.GD14439@fieldses.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, 2019-07-08 at 23:14 -0400, J. Bruce Fields wrote:
> On Thu, Jul 04, 2019 at 04:57:48PM -0700, Joe Perches wrote:
> > Probable cut&paste typo - use the correct field size.
> 
> Huh, that's been there forever, I wonder why we haven't seen crashes?
> Oh, I see, name and authname both have the same size.
> 
> Anyway, makes sense, thanks.  Will apply for 5.3.
> 
> (Unless someone else is getting this; I didn't get copied on the rest of
> the series.)

It's generally hard to cc everyone on treewide fixes like this.

There's no good mechanism I know of.
vger mailing lists reject emails with too many addressees.

Do you have an opinion on adding the stracpy macro which
could avoid many of these defects?

---
 include/linux/string.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/include/linux/string.h b/include/linux/string.h
index 4deb11f7976b..ef01bd6f19df 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -35,6 +35,22 @@ ssize_t strscpy(char *, const char *, size_t);
 /* Wraps calls to strscpy()/memset(), no arch specific code required */
 ssize_t strscpy_pad(char *dest, const char *src, size_t count);
 
+#define stracpy(to, from)					\
+({								\
+	size_t size = ARRAY_SIZE(to);				\
+	BUILD_BUG_ON(!__same_type(typeof(*to), char));		\
+								\
+	strscpy(to, from, size);				\
+})
+
+#define stracpy_pad(to, from)					\
+({								\
+	size_t size = ARRAY_SIZE(to);				\
+	BUILD_BUG_ON(!__same_type(typeof(*to), char));		\
+								\
+	strscpy_pad(to, from, size);				\
+})
+
 #ifndef __HAVE_ARCH_STRCAT
 extern char * strcat(char *, const char *);
 #endif




Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A992349E7B1
	for <lists+linux-nfs@lfdr.de>; Thu, 27 Jan 2022 17:37:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235234AbiA0Qhr (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 27 Jan 2022 11:37:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243897AbiA0Qhq (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 27 Jan 2022 11:37:46 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 896C3C061714
        for <linux-nfs@vger.kernel.org>; Thu, 27 Jan 2022 08:37:46 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 3937C608A; Thu, 27 Jan 2022 11:37:45 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 3937C608A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1643301465;
        bh=ZxzDd8iKBk/5li5TdrjofPiohZul4qOeuoFYkgcwHnA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A/rLF1VNOAdRd4tKHU+vjY5AvPtwWjheumk6/k7/8nvLoHdlbtIA1goqOsrElD8kR
         h4Ph8szRcV0g5bahTZVRG859pAtsc7gD8fptzFABwBB1qlepNvoa9kK1eKjpXqIeVl
         Xcel/bFaX1s3h9NJNSyNGLo4SEqPMDQoDpL+TnWk=
Date:   Thu, 27 Jan 2022 11:37:45 -0500
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Richard Weinberger <richard@nod.at>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>, chuck.lever@oracle.com,
        david <david@sigma-star.at>, luis.turcitu@appsbroker.com,
        chris.chilvers@appsbroker.com, david.young@appsbroker.com
Subject: Re: NFSD export parsing issue
Message-ID: <20220127163745.GB1233@fieldses.org>
References: <1986873600.300036.1643286151703.JavaMail.zimbra@nod.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1986873600.300036.1643286151703.JavaMail.zimbra@nod.at>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Jan 27, 2022 at 01:22:31PM +0100, Richard Weinberger wrote:
> Hi!
> 
> while experimenting with various modifications in mountd to deal better with crossmounts
> I noticed a problem in fs/nfsd/export.c svc_export_parse(), it always ignores the uuid
> as provided by my mountd.
> 
> If CONFIG_NFSD_V4 is not enabled, both fsloc_parse() and secinfo_parse() are a no-op.

Ugh, yeah, that's totally wrong.  The secinfo applies to v3 too, and in
the fsloc case you still want to parse the stuff even if you're only
going to ignore it.

> So I'm not sure where to address the problem. Should we fix mountd or
> change both fsloc_parse() and secinfo_parse() to consume all their
> data even in the !CONFIG_NFSD_V4 case?

Yeah, the latter.  So, maybe the remove the ifdefs.

(Should we remove CONFIG_NFSD_V4?  I doubt v3-only kernels get much
testing.)

--b.

diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
index 9421dae22737..9bdb5e102ba5 100644
--- a/fs/nfsd/export.c
+++ b/fs/nfsd/export.c
@@ -442,8 +442,6 @@ static int check_export(struct path *path, int *flags, unsigned char *uuid)
 
 }
 
-#ifdef CONFIG_NFSD_V4
-
 static int
 fsloc_parse(char **mesg, char *buf, struct nfsd4_fs_locations *fsloc)
 {
@@ -539,13 +537,6 @@ static int secinfo_parse(char **mesg, char *buf, struct svc_export *exp)
 	return 0;
 }
 
-#else /* CONFIG_NFSD_V4 */
-static inline int
-fsloc_parse(char **mesg, char *buf, struct nfsd4_fs_locations *fsloc){return 0;}
-static inline int
-secinfo_parse(char **mesg, char *buf, struct svc_export *exp) { return 0; }
-#endif
-
 static inline int
 nfsd_uuid_parse(char **mesg, char *buf, unsigned char **puuid)
 {

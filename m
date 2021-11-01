Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96DC944202C
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Nov 2021 19:39:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232017AbhKASlv (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 1 Nov 2021 14:41:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231822AbhKASlu (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 1 Nov 2021 14:41:50 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E6D3C061714
        for <linux-nfs@vger.kernel.org>; Mon,  1 Nov 2021 11:39:17 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 51F5C40E2; Mon,  1 Nov 2021 14:39:16 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 51F5C40E2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1635791956;
        bh=mWtfOyRjUA/j+wIhY46KBKtrYNtN8FYuwvqxVjuGmQI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uYRZ136zDd37rT9xMnIR8og52QOtRsxdnesp/JfkARklsmyq7RZgxZUn8lonlreWS
         IDxrNbz/+7bOTx/Ojh3q8LrjBturYfnrDUqorWiDo7q4/zOdFQCkiTEDN+KCOkOlYl
         84D03CYiAb2xiEZ9A1SVWoO/IoQUaqYdrJm0JKoM=
Date:   Mon, 1 Nov 2021 14:39:16 -0400
From:   Bruce Fields <bfields@fieldses.org>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Steve Dickson <steved@redhat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 0/1] Enable inter server to server copies on a export
Message-ID: <20211101183916.GA14427@fieldses.org>
References: <20211028144851.644018-1-steved@redhat.com>
 <20211029134534.GA19967@fieldses.org>
 <3e928624-6a7a-8583-7ea4-4eef9c22488e@redhat.com>
 <20211029164058.GE19967@fieldses.org>
 <65b31c94-54aa-5035-546c-75eb0048ba96@redhat.com>
 <20211029191435.GI19967@fieldses.org>
 <ce34c1f2-a0ad-fcb0-99fa-a1ccea8abfd7@redhat.com>
 <20211101154046.GA12965@fieldses.org>
 <93DAB7C7-D0BB-48BA-9BFF-2821D88582EA@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <93DAB7C7-D0BB-48BA-9BFF-2821D88582EA@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Nov 01, 2021 at 04:55:45PM +0000, Chuck Lever III wrote:
> 
> > On Nov 1, 2021, at 11:40 AM, J. Bruce Fields <bfields@fieldses.org> wrote:
> > 
> > On Mon, Nov 01, 2021 at 11:30:48AM -0400, Steve Dickson wrote:
> >> Hey!
> >> 
> >> On 10/29/21 15:14, J. Bruce Fields wrote:
> >>> On Fri, Oct 29, 2021 at 01:30:36PM -0400, Steve Dickson wrote:
> >>>> On 10/29/21 12:40, J. Bruce Fields wrote:
> >>>>> Let's just stick with that for now, and leave it off by default until
> >>>>> we're sure it's mature enough.  Let's not introduce new configuration to
> >>>>> work around problems that we haven't really analyzed yet.
> >>>> How is this going to find problems? At least with the export option
> >>>> it is documented
> >>> 
> >>> That sounds fixable.  We need documentation of module parameters anyway.
> >> Yeah I just took I don't see any documentation of module
> >> parameters anywhere for any of the modules. But by documentation
> >> I meant having the feature in the exports(5) manpage.
> > 
> > I think I'd probably create a new page for sysctls (this isn't the only
> > one needing documentation), and make sure it's listed in the "SEE ALSO"
> > section of the other man pages.
> 
> Aren't sysctls documented under Documentation/ ?

Sorry, I meant "module parameter".  Anyway, yes, looks like both are
listed in Documentation/admin-guide/kernel-parameters.txt.

Might be nice if these were in a man page too somewhere, but maybe
that's not the most important thing these days.

--b.

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 91ba391f9b32..14bc3f0b0149 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3243,6 +3243,19 @@
 			driver. A non-zero value sets the minimum interval
 			in seconds between layoutstats transmissions.
 
+	nfsd.inter_copy_offload_enable =
+			[NFSv4.2] When set to 1, the server will support
+			server-to-server copies for which this server is
+			the destination of the copy.
+
+	nfsd.nfsd4_ssc_umount_timeout =
+			[NFSv4.2] When used as the destination of a
+			server-to-server copy, knfsd temporarily mounts
+			the source server.  It caches the mount in case
+			it will be needed again, and discards it if not
+			used for the number of milliseconds specified by
+			this parameter.
+
 	nfsd.nfs4_disable_idmapping=
 			[NFSv4] When set to the default of '1', the NFSv4
 			server will return only numeric uids and gids to
@@ -3250,6 +3263,7 @@
 			and gids from such clients.  This is intended to ease
 			migration from NFSv2/v3.
 
+
 	nmi_backtrace.backtrace_idle [KNL]
 			Dump stacks even of idle CPUs in response to an
 			NMI stack-backtrace request.

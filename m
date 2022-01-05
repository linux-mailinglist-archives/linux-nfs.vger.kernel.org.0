Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59D1E4859D9
	for <lists+linux-nfs@lfdr.de>; Wed,  5 Jan 2022 21:13:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243910AbiAEUNQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 5 Jan 2022 15:13:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243875AbiAEUNP (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 5 Jan 2022 15:13:15 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80FD0C061245
        for <linux-nfs@vger.kernel.org>; Wed,  5 Jan 2022 12:13:15 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id E2BC56830; Wed,  5 Jan 2022 15:13:13 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org E2BC56830
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1641413593;
        bh=4L4o1Hf4tSAT3TqUaocJ0UoXmasrkC/EFkBTjY62XKE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PfRojZpY+7ucdnxfA4YxT1Vtpcw88iorAOl6xvHZYQwz912OHK/aF8Vow3NP28Evj
         WkWETJgqps1WEV3FzBp4CCoYSDpDDsK7G0No7YDpzo+WlkmWdwaPtGAxjI5vXxt4Jg
         xHM+G1LaQS14Zy0NxmhsiVUsuNTUqK6O/mSgzM04=
Date:   Wed, 5 Jan 2022 15:13:13 -0500
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     rtm@csail.mit.edu
Cc:     Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org,
        Olga Kornievskaia <kolga@netapp.com>
Subject: Re: nfsd v4 server can crash in COPY_NOTIFY
Message-ID: <20220105201313.GE25384@fieldses.org>
References: <7318.1641394756@crash.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7318.1641394756@crash.local>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Jan 05, 2022 at 09:59:16AM -0500, rtm@csail.mit.edu wrote:
> If the special ONE stateid is passed to nfs4_preprocess_stateid_op(),
> it returns status=0 but does not set *cstid. nfsd4_copy_notify()
> depends on stid being set if status=0, and thus can crash if the
> client sends the right COPY_NOTIFY RPC.
> 
> I've attached a demo.
> 
> # uname -a
> Linux (none) 5.16.0-rc7-00108-g800829388818-dirty #28 SMP Wed Jan 5 14:40:37 UTC 2022 riscv64 riscv64 riscv64 GNU/Linux
> # cc nfsd_5.c
> # ./a.out
> ...
> [   35.583265] Unable to handle kernel paging request at virtual address ffffffff00000008
> [   35.596916] status: 0000000200000121 badaddr: ffffffff00000008 cause: 000000000000000d
> [   35.597781] [<ffffffff80640cc6>] nfs4_alloc_init_cpntf_state+0x94/0xdc
> [   35.598576] [<ffffffff80274c98>] nfsd4_copy_notify+0xf8/0x28e
> [   35.599386] [<ffffffff80275c86>] nfsd4_proc_compound+0x2b6/0x4ee
> [   35.600166] [<ffffffff8025f7f4>] nfsd_dispatch+0x118/0x174
> [   35.600840] [<ffffffff8061a2e8>] svc_process_common+0x2f4/0x56c
> [   35.601630] [<ffffffff8061a624>] svc_process+0xc4/0x102
> [   35.602302] [<ffffffff8025f25a>] nfsd+0xfa/0x162
> [   35.602979] [<ffffffff80027010>] kthread+0x124/0x136
> [   35.603668] [<ffffffff8000303e>] ret_from_exception+0x0/0xc
> [   35.604667] ---[ end trace 69f12ad62072e251 ]---

We could do something like this.--b.

Author: J. Bruce Fields <bfields@redhat.com>
Date:   Wed Jan 5 14:15:03 2022 -0500

    nfsd: fix crash on COPY_NOTIFY with special stateid
    
    RTM says "If the special ONE stateid is passed to
    nfs4_preprocess_stateid_op(), it returns status=0 but does not set
    *cstid. nfsd4_copy_notify() depends on stid being set if status=0, and
    thus can crash if the client sends the right COPY_NOTIFY RPC."
    
    RFC 7862 says "The cna_src_stateid MUST refer to either open or locking
    states provided earlier by the server.  If it is invalid, then the
    operation MUST fail."
    
    The RFC doesn't specify an error, and the choice doesn't matter much as
    this is clearly illegal client behavior, but bad_stateid seems
    reasonable.
    
    Simplest is just to guarantee that nfs4_preprocess_stateid_op, called
    with non-NULL cstid, errors out if it can't return a stateid.
    
    Reported-by: rtm@csail.mit.edu
    Fixes: 624322f1adc5 ("NFSD add COPY_NOTIFY operation")
    Signed-off-by: J. Bruce Fields <bfields@redhat.com>

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 1956d377d1a6..b94b3bb2b8a6 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -6040,7 +6040,11 @@ nfs4_preprocess_stateid_op(struct svc_rqst *rqstp,
 		*nfp = NULL;
 
 	if (ZERO_STATEID(stateid) || ONE_STATEID(stateid)) {
-		status = check_special_stateids(net, fhp, stateid, flags);
+		if (cstid)
+			status = nfserr_bad_stateid;
+		else
+			status = check_special_stateids(net, fhp, stateid,
+									flags);
 		goto done;
 	}
 

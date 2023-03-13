Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74C066B8131
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Mar 2023 19:52:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbjCMSwp (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 13 Mar 2023 14:52:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230348AbjCMSwk (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 13 Mar 2023 14:52:40 -0400
Received: from mta-202a.earthlink-vadesecure.net (mta-202a.earthlink-vadesecure.net [51.81.232.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81A9387D89
        for <linux-nfs@vger.kernel.org>; Mon, 13 Mar 2023 11:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; bh=oG2zkBHECJV3tlUKfRN5S28gOo2vYl2vPmQcwF
 8PlWM=; c=relaxed/relaxed; d=earthlink.net; h=from:reply-to:subject:
 date:to:cc:resent-date:resent-from:resent-to:resent-cc:in-reply-to:
 references:list-id:list-help:list-unsubscribe:list-subscribe:list-post:
 list-owner:list-archive; q=dns/txt; s=dk12062016; t=1678733505;
 x=1679338305; b=WHVrV4EEpVSkAYT6UAcfx/fTd8uzDrQ7lWvbVes1oLWAR7UOPO7Q6zo
 SuWS/1Be1zlrqgrqZPaUVPF+lTKUE2lkbxIcw6MteMdShzwJTmQDV0X7VWaXknuUeoe08ry
 pptLflLNTJQhKmSLIQ8IjB6v4CUdgq39VicW/McKAMxJk1rDNWJhISH5uG4lvR4PSSfk6M1
 ruXQ/r2OVQNiZrZhGycstsTC1j7f8GdVkPH9r7UjqBR+cEtCgaUI3PdnVMaW5CQtpNwBiAb
 w0RCYnTxIq5YXomgzrqJ6IuXDyFHY0Jp5jaHKNib8rMqD0ZZOcfHssOPamm+Ax8++89Uq+i
 GZA==
Received: from FRANKSTHINKPAD ([174.174.49.201])
 by smtp.earthlink-vadesecure.net ESMTP vsel2nmtao02p with ngmta
 id 2722aa24-174c0f3a9ff57743; Mon, 13 Mar 2023 18:51:45 +0000
From:   "Frank Filz" <ffilzlnx@mindspring.com>
To:     "'Jeff Layton'" <jlayton@kernel.org>, <calum.mackay@oracle.com>
Cc:     <bfields@fieldses.org>, <linux-nfs@vger.kernel.org>,
        "'Frank Filz'" <ffilz@redhat.com>
References: <20230313112401.20488-1-jlayton@kernel.org> <20230313112401.20488-6-jlayton@kernel.org>
In-Reply-To: <20230313112401.20488-6-jlayton@kernel.org>
Subject: RE: [pynfs PATCH v2 5/5] LOCK24: fix the lock_seqid in second lock request
Date:   Mon, 13 Mar 2023 11:51:45 -0700
Message-ID: <05c001d955dc$dc7e6fa0$957b4ee0$@mindspring.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 15.0
Content-Language: en-us
Thread-Index: AQIOChUlYc/UeF2748/fISU/E8FFiQF2dM0froPxqqA=
Authentication-Results: earthlink-vadesecure.net;
 auth=pass smtp.auth=ffilzlnx@mindspring.com smtp.mailfrom=ffilzlnx@mindspring.com;
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Looks good to me, tested against Ganesha and the updated patch passes.

Frank

> -----Original Message-----
> From: Jeff Layton [mailto:jlayton@kernel.org]
> Sent: Monday, March 13, 2023 4:24 AM
> To: calum.mackay@oracle.com
> Cc: bfields@fieldses.org; ffilzlnx@mindspring.com;
linux-nfs@vger.kernel.org;
> Frank Filz <ffilz@redhat.com>
> Subject: [pynfs PATCH v2 5/5] LOCK24: fix the lock_seqid in second lock
request
> 
> This test currently fails against Linux nfsd, but I think it's the test
that's wrong. It
> basically does:
> 
> open for read
> read lock
> unlock
> open upgrade
> write lock
> 
> The write lock above is sent with a lock_seqid of 0, which is wrong.
> RFC7530/16.10.5 says:
> 
>    o  In the case in which the state has been created and the [new
>       lockowner] boolean is true, the server rejects the request with the
>       error NFS4ERR_BAD_SEQID.  The only exception is where there is a
>       retransmission of a previous request in which the boolean was
>       true.  In this case, the lock_seqid will match the original
>       request, and the response will reflect the final case, below.
> 
> Since the above is not a retransmission, knfsd is correct to reject this
call. This
> patch fixes the open_sequence object to track the lock seqid and set it
correctly
> in the LOCK request.
> 
> With this, LOCK24 passes against knfsd.
> 
> Cc: Frank Filz <ffilz@redhat.com>
> Fixes: 4299316fb357 (Add LOCK24 test case to test open uprgade/downgrade
> scenario)
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  nfs4.0/servertests/st_lock.py | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/nfs4.0/servertests/st_lock.py b/nfs4.0/servertests/st_lock.py
index
> 468672403ffe..9d650ab017b9 100644
> --- a/nfs4.0/servertests/st_lock.py
> +++ b/nfs4.0/servertests/st_lock.py
> @@ -886,6 +886,7 @@ class open_sequence:
>          self.client = client
>          self.owner = owner
>          self.lockowner = lockowner
> +        self.lockseqid = 0
>      def open(self, access):
>          self.fh, self.stateid = self.client.create_confirm(self.owner,
>  						access=access,
> @@ -900,14 +901,17 @@ class open_sequence:
>          self.client.close_file(self.owner, self.fh, self.stateid)
>      def lock(self, type):
>          res = self.client.lock_file(self.owner, self.fh, self.stateid,
> -                    type=type, lockowner=self.lockowner)
> +                                    type=type, lockowner=self.lockowner,
> +                                    lockseqid=self.lockseqid)
>          check(res)
>          if res.status == NFS4_OK:
>              self.lockstateid = res.lockid
> +            self.lockseqid += 1
>      def unlock(self):
>          res = self.client.unlock_file(1, self.fh, self.lockstateid)
>          if res.status == NFS4_OK:
>              self.lockstateid = res.lockid
> +            self.lockseqid += 1
> 
>  def testOpenUpgradeLock(t, env):
>      """Try open, lock, open, downgrade, close
> --
> 2.39.2


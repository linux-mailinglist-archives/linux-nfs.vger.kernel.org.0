Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6150712D068
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Dec 2019 14:41:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727483AbfL3Nlp (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 30 Dec 2019 08:41:45 -0500
Received: from mail-lf1-f43.google.com ([209.85.167.43]:44096 "EHLO
        mail-lf1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727445AbfL3Nlo (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 30 Dec 2019 08:41:44 -0500
Received: by mail-lf1-f43.google.com with SMTP id v201so25130164lfa.11;
        Mon, 30 Dec 2019 05:41:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:references:in-reply-to:subject:date:message-id
         :mime-version:content-transfer-encoding:thread-index
         :content-language;
        bh=nSnNuDmIxk9D1cWa2tIsDeJnMaH3k9bbBRnOjY8Xz2s=;
        b=dqxvn/cGLpZqNffjzVAoJ+a2LLKoXGp3ryGHp3+2icbx3xI8lA2BKnenqenDRTTQnX
         gylk8OI0NHpSF2Qqe0SB8tBqnzbp4Rkin3/Nf8MQdNJJhjCeSU4ZCXsmISYEgmm3svl0
         PQ3iLLU7qW60y1v01KMgnWepSTezjDtnvr7dM23+8NZC7BN0KbsNKTh7Fjd1haGvnIz7
         5iOlbE1mAMVr5XYVthyodV6Ibo+2iuZSMl30AbdeTpBiYKZXbJz7fmc8SNvltLD80/kt
         I0ezVD1zZWHvsbeM8cRWCm2r3jvZVtPLGObJ58/euvv5/6/bbxRyeYztN29hj8/8rC1j
         9jqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:references:in-reply-to:subject:date
         :message-id:mime-version:content-transfer-encoding:thread-index
         :content-language;
        bh=nSnNuDmIxk9D1cWa2tIsDeJnMaH3k9bbBRnOjY8Xz2s=;
        b=KVlG+56WHQx/wl+vhnCA+Zb76d7cg+paUAnpimhQqdA/BSRNU16+8DAj1lYPkF+6JD
         VdUvmtPT8dIi2UkqKZJB+cwVlryGMJhJctRWycq7/J08giSBCBiRLxtWOcZwxiWpVcYr
         SWDD+IGYTnkrkuN0uOkFzXYY3iAvos9DzbcAkTk35dElNzvDkKi56txKFEf+G1HQpdFC
         QOKuSu3paOKJLxmHinmvHKaI7fU6M/AOx4BejthONXLVMmqAnNoS96/bs/14z4P1FXhf
         0HyuBku5hNORFT196lwctKa/pzsXrxYpkNMFZcH9a2AsjZn5CXnwy06xYawdwBxiT0LQ
         6dyw==
X-Gm-Message-State: APjAAAWgyan6dMwo1/M62uJlWJs2pamtGJ+2OASYxC0dsLV3KCwiGMOw
        pci4D6Z5/KWcKUhZyMEtHbk=
X-Google-Smtp-Source: APXvYqwakLFSP2KDkJlY8c7Lc/vJIu6sxdzr4NpkkY5EvlqYoKuLkE0siKob4YzC2h7sofjxhhYPZg==
X-Received: by 2002:a19:e011:: with SMTP id x17mr20848863lfg.59.1577713301391;
        Mon, 30 Dec 2019 05:41:41 -0800 (PST)
Received: from loulrmilkow1 (227.46-29-148.tkchopin.pl. [46.29.148.227])
        by smtp.gmail.com with ESMTPSA id e17sm17636283ljg.101.2019.12.30.05.41.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Dec 2019 05:41:40 -0800 (PST)
From:   "Robert Milkowski" <rmilkowski@gmail.com>
To:     "'Chuck Lever'" <chuck.lever@oracle.com>
Cc:     "'Linux NFS Mailing List'" <linux-nfs@vger.kernel.org>,
        "'Trond Myklebust'" <trond.myklebust@hammerspace.com>,
        "'Anna Schumaker'" <anna.schumaker@netapp.com>,
        <linux-kernel@vger.kernel.org>
References: <001901d5ba67$8954ede0$9bfec9a0$@gmail.com> <594E0E04-1253-4C0D-8A58-EB4AF883B7EC@oracle.com> <015901d5bce8$d6957010$83c05030$@gmail.com> <7BCC7682-CA85-4B97-BAD4-A6A1D1DD43D9@oracle.com>
In-Reply-To: <7BCC7682-CA85-4B97-BAD4-A6A1D1DD43D9@oracle.com>
Subject: RE: [PATCH v2] NFSv4.0: nfs4_do_fsinfo() should not do implicit lease
Date:   Mon, 30 Dec 2019 13:41:39 -0000
Message-ID: <022f01d5bf16$dda484b0$98ed8e10$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQFtSHQznciB4gB7iYqNNX8PSbx2NgLYPe2PAi6VNywCnAZKrqhma1gQ
Content-Language: en-gb
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

> 
> Wrap at 72, but OK. Some prefer short descriptions, but I like to
> have enough bread crumbs to find my way back to the purpose of a
> commit when I've forgotten it 6 months from now.
> 
> A timing-related failure is obnoxious, so this explanation is going
> to also help sustaining engineers locate this fix quickly if needed.

Agree.


> Interesting to test what happens if:
> 
> a) the server fails the COMPOUND before getting to the RENEW?


There is no change in behaviour in this case.
The nfs4_xdr_dec_fsinfo() returns first error without decoding any further operations in the compound.
Then depending on the error we might end up retrying in nfs4_do_fsinfo():
 
...
        do {
                err = _nfs4_do_fsinfo(server, fhandle, fsinfo);
                trace_nfs4_fsinfo(server, fhandle, fsinfo->fattr, err);
                if (err == 0) {
                        nfs4_set_lease_period(server->nfs_client,
                                        fsinfo->lease_time * HZ,
                                        now);
                        break;
                }
                err = nfs4_handle_exception(server, err, &exception);
        } while (exception.retry);
        return err;
...


For example, currently it will retry with RENEW if it got NFS4ERR_STALE_CLIENTID from any operations in the compound op here.
However, it won't do so for NFS4ERR_EXPIRED currently - this is another bug I'm addressing via a different patch (it affects not
just RENEW but other operations like open(), etc.), see email: [PATCH] NFSv4: open() should try lease recovery on NFS4ERR_EXPIRED
I will be sending updated patch there in coming days as well.

In this specific case when mounting a sub-mount and NFS4ERR_EXPIRED is returned by server we fail to mount, with or without my
patch.

> 
> b) the RENEW itself fails; does the client correctly perform state
> recovery in that case?
> 

Same as above really, as we don't care in this case which operation in the compound returned an error - we start error handling on
first operation which errored out without checking the others. I did check that we handle correctly NFS4ERR_STALE_CLIENTID for
example (we re-issue RENEW), but we do not NFS4ERR_EXPIRED correctly here.
I don't think it matters in regards to the patch discussed here, as if NFS4ERR_EXPIRERED is returned, without this patch we would
end up mounting a sub-mount but erroring out on any file access (like open()), while with the patch we won't mount a sub-mount and
still return same error to open().

To fix it, we need the other mentioned patch, which is orthogonal here.

However, there is an improvement here by having the patch discussed here for the nfs4_do_fsinfo() - without the patch we definitely
do end up with expired lease situation as described which does result in NFS4ERR_EXPIRED returned by some nfs servers which
currently translates to EIO returned by OPEN(), while with the patch this specific condition will not happen in the first place,
therefor NFS4ERR_EXPIRED won't be returned here and we won't hit the other issue.



> > Also, before the 83ca7f5ab31f, implicit lease renewal was only done in
> nfs4_proc_setclientid_confirm(),
> > but the function is not called when mounting a sub-mount, and it was not done in nfs4_do_fsinfo()
> either.
> > The implicit renewal in nfs4_do_fsinfo() when mounting each submount was introduced by the commit,
> before it only happened on root
> > mount.
> > So this particular issue I'm trying to fix here did not occur before the change, I think.
> 
> Does that alter your explanation in the patch description?

No, I don't think so.


> Does 83ca7f5 make things worse?

What I meant was that it is the 83ca7f5 commit which introduced the issue by assuming implicit renewal in a different code path
which is called on every mount (sub-mount or not). Before the commit although there was an implicit renewal in
nfs4_proc_setclientid_confirm(), I believe
it was harmless as this one is essentially only called if clientid is not set yet, in which case a server would just set
last_renewal as well.

What the 83ca7f5 commit introduced is an implicit renew in do_fsinfo() which is called on every mount of a sub-mount, in which case
both sides (client and server)
already have clientid established, so what it does is it delays RENEW op being send by client which in turn means there is a short
window during which lease actually expires from server but not client point of view. In extreme case when one mounts/unmounts a
sub-mount RENEW operation is not being send at all.



Let me describe the issue again with an example timeline.
At some point /mnt/fs1 is mounted over nfsv4.0, then RENEW is issued every 60s by a client (assuming server has grace period set to
90s and no other nfs operations are being send, in which case Linux sends RENEW every 2/3 of 90 = 60s). Let's pick up one such
RENEW and assume time 0:

0   RENEW
60  RENEW
120 RENEW
178 stat /mnt/fs1/submount
    Results in /mnt/fs1/submount being mounted
    Linux client wrongly assumes implicit lease renewal in nfs4_do_fsinfo() (introduced by 83ca7f5), but server does not
210 lease expires from server perspective (120 + 90)
215 open(/mnt/fs1/submount/f1) results in NFS4ERR_EXPIRED returned by server and EIO returned to an application (due to the other
bug mentioned above)
238 next RENEW scheduled by client
    Server returns NFS4ERR_EXPIRED
    Client tries again and then recovers via SETCLIENTID

So in the above case, there is a window of 28s (238-210) where all open() calls (and many other) will fail.

The discussed patch here makes the implicit RENEW at 178 into an explicit one (or originally in v1 version of the patch I removed
the implicit renewal here altogether), so now both server and client renew the lease and there won't be a window where we let the
lease expire.

At 215 the open() fails to recover due to bug in nfs4_do_handle_exception() as briefly discussed above and in more detail in the
separate email/patch, while at 238 RENEW recovers from NFS4ERR_EXPIRED as error handling is done in nfs4_renew_done() which does
the right thing by calling nfs4_schedule_lease_recovery().


-- 
Robert Milkowski



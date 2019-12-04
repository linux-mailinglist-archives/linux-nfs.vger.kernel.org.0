Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9BF211362C
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Dec 2019 21:11:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727989AbfLDULO (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 4 Dec 2019 15:11:14 -0500
Received: from mail-ua1-f43.google.com ([209.85.222.43]:32968 "EHLO
        mail-ua1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727033AbfLDULN (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 4 Dec 2019 15:11:13 -0500
Received: by mail-ua1-f43.google.com with SMTP id a13so306776uaq.0
        for <linux-nfs@vger.kernel.org>; Wed, 04 Dec 2019 12:11:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8M5KPf6gzqhwGyQGFlpeC/pbw6q1e8aVo9w/9Axac20=;
        b=kscMIwhC8gFdyce9/tOvOLfjmTi9RaSQH6auKbR1DcsSmCP2ub5XF6s0PfAqvfeHap
         xbXwrR3iCEwlm/zrsOVRFXrAdvzc+Gb5IP5EaLQNB6ZDYpX0+Nvm9/7G3RCn/0HWaRFJ
         VsFY1PSxngzLM0LDZxLIhaNNfwIEeHmnf/Phnuls3Y1grZ6/u0p2stE2k/iaUkTaasIK
         fE+IRFZYh1F3BBWU24CIa7Gtff/oK8XJrlhBh4FBVUEqGKnbVsZm3aI/PTJqV0sKVPt4
         TLqJ9Y10R2/TFFW5eSe9h2i3FL+P4RPeASfdgcsl4fGPf0eDQnCzrTg0fCCGbvTZ6ef7
         jGBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8M5KPf6gzqhwGyQGFlpeC/pbw6q1e8aVo9w/9Axac20=;
        b=S+GcVuhop+/c3wCj5XFa9ADbFNt5pacXnKaLRCidlSsGOR60Hyv6KN6unx9HolGjFq
         rg43URUWSjDF6LLQijCTSVxGugmurLpysGtOkAcc22OMy+UXnPsaGzUzdjCJqFbXfu40
         E+We4cWPbeAStHS1CxooaUCGYUoHClRUDcR9V6aHARrvdSx2ddxe67N5EKEPf7rEIKQ8
         hY0qSTk4dG5T1Hcx0965GEKyx2Aq6FHXgyjyLQZkwwMwHdwSTICt3NDacztr5k31pdBn
         iIKc8lZZuA/wjtDyTHgkQ9GLVDkuE5AokyE04uoKlJC0b3FXEROwboMVAvqu/iY5Bt0k
         jyxA==
X-Gm-Message-State: APjAAAV/U03UPeEWmFqS3KhDQe/VRRE5gliRqN5lW47z1rnELY8HT7p1
        RIGOu5eS6jputt/IZPlWi09CEb088LexVRW0F4Q=
X-Google-Smtp-Source: APXvYqwdBJuwBc8lpfWL7ZVZ3K/Pp2LssXaToRG7FAnM+zWFVcgrMpNqnpbct3F2a4sc56eZzhwGEAK5NJ0IImX4jt8=
X-Received: by 2002:ab0:3381:: with SMTP id y1mr736117uap.93.1575490272616;
 Wed, 04 Dec 2019 12:11:12 -0800 (PST)
MIME-Version: 1.0
References: <20191204080039.ixjqetefkzzlldyt@kili.mountain>
In-Reply-To: <20191204080039.ixjqetefkzzlldyt@kili.mountain>
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
Date:   Wed, 4 Dec 2019 15:11:01 -0500
Message-ID: <CAN-5tyEG3C_Ebdr6dpMJ+gQ1pEAMNqbTv76dKu=KK9rspREr1A@mail.gmail.com>
Subject: Re: [bug report] NFSD: allow inter server COPY to have a STALE source
 server fh
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        "J. Bruce Fields" <bfields@redhat.com>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Dec 4, 2019 at 3:00 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> Hello Olga Kornievskaia,
>
> This is a semi-automatic email about new static checker warnings.
>
> The patch 4e48f1cccab3: "NFSD: allow inter server COPY to have a
> STALE source server fh" from Oct 7, 2019, leads to the following
> Smatch complaint:
>
>     fs/nfsd/nfs4proc.c:2371 nfsd4_proc_compound()
>      error: we previously assumed 'current_fh->fh_export' could be null (see line 2325)
>
> fs/nfsd/nfs4proc.c
>   2324                          }
>   2325                  } else if (current_fh->fh_export &&
>                                    ^^^^^^^^^^^^^^^^^^^^^
> The patch adds a check for NULL
>
>   2326                             current_fh->fh_export->ex_fslocs.migrated &&
>   2327                            !(op->opdesc->op_flags & ALLOWED_ON_ABSENT_FS)) {
>   2328                          op->status = nfserr_moved;
>   2329                          goto encode_op;
>   2330                  }
>   2331
>   2332                  fh_clear_wcc(current_fh);
>   2333
>   2334                  /* If op is non-idempotent */
>   2335                  if (op->opdesc->op_flags & OP_MODIFIES_SOMETHING) {
>   2336                          /*
>   2337                           * Don't execute this op if we couldn't encode a
>   2338                           * succesful reply:
>   2339                           */
>   2340                          u32 plen = op->opdesc->op_rsize_bop(rqstp, op);
>   2341                          /*
>   2342                           * Plus if there's another operation, make sure
>   2343                           * we'll have space to at least encode an error:
>   2344                           */
>   2345                          if (resp->opcnt < args->opcnt)
>   2346                                  plen += COMPOUND_ERR_SLACK_SPACE;
>   2347                          op->status = nfsd4_check_resp_size(resp, plen);
>   2348                  }
>   2349
>   2350                  if (op->status)
>   2351                          goto encode_op;
>   2352
>   2353                  if (op->opdesc->op_get_currentstateid)
>   2354                          op->opdesc->op_get_currentstateid(cstate, &op->u);
>   2355                  op->status = op->opdesc->op_func(rqstp, cstate, &op->u);
>   2356
>   2357                  /* Only from SEQUENCE */
>   2358                  if (cstate->status == nfserr_replay_cache) {
>   2359                          dprintk("%s NFS4.1 replay from cache\n", __func__);
>   2360                          status = op->status;
>   2361                          goto out;
>   2362                  }
>   2363                  if (!op->status) {
>   2364                          if (op->opdesc->op_set_currentstateid)
>   2365                                  op->opdesc->op_set_currentstateid(cstate, &op->u);
>   2366
>   2367                          if (op->opdesc->op_flags & OP_CLEAR_STATEID)
>   2368                                  clear_current_stateid(cstate);
>   2369
>   2370                          if (need_wrongsec_check(rqstp))
>   2371                                  op->status = check_nfsd_access(current_fh->fh_export, rqstp);
>                                                                        ^^^^^^^^^^^^^^^^^^^^^
> Is it required here as well?

Bruce, correct me if I'm wrong but I think we are ok here. Because for
the COPY operation for which the current_fh->fh_export can be null,
need_wrongsec_check() would be false.

>
>   2372                  }
>   2373  encode_op:
>
> regards,
> dan carpenter

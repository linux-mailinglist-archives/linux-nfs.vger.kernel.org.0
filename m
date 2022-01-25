Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA47049BED5
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Jan 2022 23:46:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234097AbiAYWqw (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 25 Jan 2022 17:46:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:45425 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234071AbiAYWqv (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 25 Jan 2022 17:46:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643150811;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jBppPkwSy/vM41RL2L/gnKARInPVcNL6jVjDfCgabzo=;
        b=bMv5r503zctDozz9LobV4sJamkZLktSPZud49Taoa0HMzDxTOApKPmbv6bqh15Q2QiaPJ+
        eOjU5wunA5IhmAQqxGmeI5Ysy8sA9B1ESORpx0hUP+f9BxikcNORzYPGkVCmiaBjEIQYZO
        dZU/pBy0GA5HZdcxUfzlp78dwFWNOW8=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-27-dDYBGFMrNtCyj11bEY8ftw-1; Tue, 25 Jan 2022 17:46:49 -0500
X-MC-Unique: dDYBGFMrNtCyj11bEY8ftw-1
Received: by mail-il1-f197.google.com with SMTP id t18-20020a92ca92000000b002b952c60bfbso11614852ilo.15
        for <linux-nfs@vger.kernel.org>; Tue, 25 Jan 2022 14:46:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jBppPkwSy/vM41RL2L/gnKARInPVcNL6jVjDfCgabzo=;
        b=4nJAs7wrJv5Cgbr/YHRQ2nQFVs0ia6supNiJFRk0B8vnUyxQtJGyrfmP3qlIUZ7Z3d
         TLC3TsuU7ZTcaIPf+pSBNst6QueOAiBvrii3DH96rn1NB0MTAwcx+bgAdOsPts21mMwl
         4fCLqk3kHLSROL1uJfzesKgdcsD6B1jhMRzUv0GipcPS3UX0IxfKG/eGgDov+7/0CFRG
         gCBsviXQwjiw3h13AjPgYGgmQwRRCdNeSklMBatJkzOk+APdeP27nfiJ5214B2tj4B9x
         ikVetSllcqOACg0VGOgH5/55duklTkJYWo1keRqUkJJQA16tnPOuQPj6dgIv+mt3++Fh
         o+Gw==
X-Gm-Message-State: AOAM530dAqlSrMjAp49tkkdk5nlhx06GkezSG5wjqnAgniK5WVDbnXf+
        Ql0sSbK6zUt7DXGnCQSZWLnnYG5h8FZ/wUhpt9tQaf3yWb4v12I56x44lEUtMnrPHOz8tOvy62y
        sO+GDParQGyttQMiSbaOigFDlVT9AHmkrXTtZ
X-Received: by 2002:a5e:9709:: with SMTP id w9mr12201204ioj.86.1643150809083;
        Tue, 25 Jan 2022 14:46:49 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy8jmhq/jj20NC3GXEAJ4rIxEGsh6Ac0CBVLtVrUFmS/V4inTnhidWihmWEFMlCjLXFlvU6KT6kSQJ3JU/onXU=
X-Received: by 2002:a5e:9709:: with SMTP id w9mr12201191ioj.86.1643150808912;
 Tue, 25 Jan 2022 14:46:48 -0800 (PST)
MIME-Version: 1.0
References: <YLY9pKu38lEWaXxE@pevik> <YLZS1iMJR59n4hue@pick.fieldses.org> <164248153844.24166.16775550865302060652@noble.neil.brown.name>
In-Reply-To: <164248153844.24166.16775550865302060652@noble.neil.brown.name>
From:   Bruce Fields <bfields@redhat.com>
Date:   Tue, 25 Jan 2022 17:46:38 -0500
Message-ID: <CAPL3RVE8+zYOLotpUQ6QWFy5rYS8o1NV6XbKE4-D6XpVSoYw3w@mail.gmail.com>
Subject: Re: pynfs: [NFS 4.0] SEC7, LOCK24 test failures
To:     NeilBrown <neilb@suse.de>
Cc:     Petr Vorel <pvorel@suse.cz>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Yong Sun <yosun@suse.com>,
        "Frank S. Filz" <ffilzlnx@mindspring.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Frank added this test in 4299316fb357, and I don't really understand
his description, but it *sounds* like he really wanted it to do the
new-lockowner case.  Frank?

--b.

On Tue, Jan 18, 2022 at 12:01 AM NeilBrown <neilb@suse.de> wrote:
>
> On Wed, 02 Jun 2021, J. Bruce Fields wrote:
> > On Tue, Jun 01, 2021 at 04:01:08PM +0200, Petr Vorel wrote:
> >
> > > LOCK24   st_lock.testOpenUpgradeLock                              : FAILURE
> > >            OP_LOCK should return NFS4_OK, instead got
> > >            NFS4ERR_BAD_SEQID
> >
> > I suspect the server's actually OK here, but I need to look more
> > closely.
> >
> I agree.
> I think this patch fixes the test.
>
> NeilBrown
>
> From: NeilBrown <neilb@suse.de>
> Date: Tue, 18 Jan 2022 15:50:37 +1100
> Subject: [PATCH] Fix NFSv4.0 LOCK24 test
>
> Only the first lock request for a given open-owner can use lock_file.
> Subsequent lock request must use relock_file.
>
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>  nfs4.0/servertests/st_lock.py | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/nfs4.0/servertests/st_lock.py b/nfs4.0/servertests/st_lock.py
> index 468672403ffe..db08fbeedac4 100644
> --- a/nfs4.0/servertests/st_lock.py
> +++ b/nfs4.0/servertests/st_lock.py
> @@ -886,6 +886,7 @@ class open_sequence:
>          self.client = client
>          self.owner = owner
>          self.lockowner = lockowner
> +        self.lockseq = 0
>      def open(self, access):
>          self.fh, self.stateid = self.client.create_confirm(self.owner,
>                                                 access=access,
> @@ -899,15 +900,21 @@ class open_sequence:
>      def close(self):
>          self.client.close_file(self.owner, self.fh, self.stateid)
>      def lock(self, type):
> -        res = self.client.lock_file(self.owner, self.fh, self.stateid,
> -                    type=type, lockowner=self.lockowner)
> +        if self.lockseq == 0:
> +            res = self.client.lock_file(self.owner, self.fh, self.stateid,
> +                                        type=type, lockowner=self.lockowner)
> +        else:
> +            res = self.client.relock_file(self.lockseq, self.fh, self.lockstateid,
> +                                        type=type)
>          check(res)
>          if res.status == NFS4_OK:
>              self.lockstateid = res.lockid
> +            self.lockseq = self.lockseq + 1
>      def unlock(self):
>          res = self.client.unlock_file(1, self.fh, self.lockstateid)
>          if res.status == NFS4_OK:
>              self.lockstateid = res.lockid
> +            self.lockseq = self.lockseq + 1
>
>  def testOpenUpgradeLock(t, env):
>      """Try open, lock, open, downgrade, close
> --
> 2.34.1
>


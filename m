Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 859D71B0891
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Apr 2020 13:58:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726416AbgDTL6M (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 20 Apr 2020 07:58:12 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:24617 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726606AbgDTL6L (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 20 Apr 2020 07:58:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587383889;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+y1lT01n5LFQXR5L/0fi5pH+uoGk38PvjIvfNQPImu8=;
        b=AsmHoVm6Obwcwxvd2ZZ7GO16QZrqUneaxvnGQUH7EaJ0iWL8iVXZy5riZZsWaGAxcTVEVC
        X59itjdfDZvcVqEgRz4mp+sGw+bsdrEKXKxmKPtYa434SupJJYckhOrHqNMwIG7Jwd/itu
        46qWSiPB5nzWrDGVtQ42Lc39oEbpqmc=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-283-z081lBAgMHC4hLrmdYhSBA-1; Mon, 20 Apr 2020 07:58:08 -0400
X-MC-Unique: z081lBAgMHC4hLrmdYhSBA-1
Received: by mail-lf1-f71.google.com with SMTP id b16so4128101lfb.19
        for <linux-nfs@vger.kernel.org>; Mon, 20 Apr 2020 04:58:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+y1lT01n5LFQXR5L/0fi5pH+uoGk38PvjIvfNQPImu8=;
        b=Xads+AFPCtyzgtCK5lbU6q2SP/yXw28yEkJ3On3cPHG1G3rIaoArkhy7s1klpUqLTx
         z9Vrb+ZpBGExmr6YrJkVjFhzmgxjmRLwgUn0L9S47nGldMw6B+3rwTttD2oi+2TsX+5Q
         bgPMSKUEqjbaRqB6gWTnd3ds+QxtH19F3rwUmF0+jcvk4CNcs7v/5XAfITrrmE4gtt1W
         JNcFpIk0oO0i97k0qbKQ0RRKjqK7Rc2365DY6SAG6iw+mwfc/11SskmxVHu0R8wqreRF
         wIx209WwE2ssTHG65LMwHqTp8dJAcmYAouefsdea9/eFoNQXv/NJHKEB7LqZ1glw8j9w
         Fypg==
X-Gm-Message-State: AGi0PuZQJ9kSM2oNppE/y8DvWPPAJcggvzHLotckxcYDA6W5bFscN/7m
        4CYSXVHSdzfKH9CkjDkehNO2QmjwePFTZbOgL5QhWRUiuo/nM6FT6Y8hjmdiNWqtBZb1BU46uoX
        sTcEjHinznjc6eyv9g3lNLzBz2LHkuNPO8kdd
X-Received: by 2002:ac2:4c9a:: with SMTP id d26mr10014020lfl.112.1587383886177;
        Mon, 20 Apr 2020 04:58:06 -0700 (PDT)
X-Google-Smtp-Source: APiQypLnmwaOqm3YU4vexvj8XobaslZtScVjVVgsLYs4UNtEOnhdnZ4IVDBNXVj1COrgoaPXRvSyHLcI4LzuwYC3PeQ=
X-Received: by 2002:ac2:4c9a:: with SMTP id d26mr10014011lfl.112.1587383885965;
 Mon, 20 Apr 2020 04:58:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200420045952.GA61440@nevermore.foobar.lan>
In-Reply-To: <20200420045952.GA61440@nevermore.foobar.lan>
From:   Achilles Gaikwad <agaikwad@redhat.com>
Date:   Mon, 20 Apr 2020 17:27:54 +0530
Message-ID: <CAK0MK2qS3HR=CwzPpLR7g+F9HRCB+7kv7APFtmjkOV7xj5xUGw@mail.gmail.com>
Subject: Re: [PATCH v2] nfsd4: add filename to states output
To:     linux-nfs@vger.kernel.org
Cc:     bfields@fieldses.org, Trond Myklebust <trondmy@hammerspace.com>,
        Kenneth Dsouza <kdsouza@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

There's a minor Bug that needs squashing in the code I sent. I'll send a V3. :)
Sorry for the trouble.

Best,
- Achilles
---

On Mon, Apr 20, 2020 at 10:30 AM Achilles Gaikwad <agaikwad@redhat.com> wrote:
>
> Add filename to states output for ease of debugging.
>
> Signed-off-by: Achilles Gaikwad <agaikwad@redhat.com>
> Signed-off-by: Kenneth Dsouza <kdsouza@redhat.com>
> ---
>  fs/nfsd/nfs4state.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index e32ecedece0f..f1cc825ff20b 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -2404,6 +2404,11 @@ static void states_stop(struct seq_file *s, void *v)
>         spin_unlock(&clp->cl_lock);
>  }
>
> +static void nfs4_show_fname(struct seq_file *s, struct nfsd_file *f)
> +{
> +         seq_printf(s, "filename: \"%pD2\"", f->nf_file);
> +}
> +
>  static void nfs4_show_superblock(struct seq_file *s, struct nfsd_file *f)
>  {
>         struct inode *inode = f->nf_inode;
> @@ -2449,6 +2454,8 @@ static int nfs4_show_open(struct seq_file *s, struct nfs4_stid *st)
>
>         nfs4_show_superblock(s, file);
>         seq_printf(s, ", ");
> +       nfs4_show_fname(s, file);
> +       seq_printf(s, ", ");
>         nfs4_show_owner(s, oo);
>         seq_printf(s, " }\n");
>         nfsd_file_put(file);
> @@ -2480,6 +2487,8 @@ static int nfs4_show_lock(struct seq_file *s, struct nfs4_stid *st)
>         nfs4_show_superblock(s, file);
>         /* XXX: open stateid? */
>         seq_printf(s, ", ");
> +       nfs4_show_fname(s, file);
> +       seq_printf(s, ", ");
>         nfs4_show_owner(s, oo);
>         seq_printf(s, " }\n");
>         nfsd_file_put(file);
> @@ -2506,6 +2515,7 @@ static int nfs4_show_deleg(struct seq_file *s, struct nfs4_stid *st)
>         /* XXX: lease time, whether it's being recalled. */
>
>         nfs4_show_superblock(s, file);
> +       nfs4_show_fname(s, file);
>         seq_printf(s, " }\n");
>
>         return 0;
> @@ -2524,6 +2534,7 @@ static int nfs4_show_layout(struct seq_file *s, struct nfs4_stid *st)
>         /* XXX: What else would be useful? */
>
>         nfs4_show_superblock(s, file);
> +       nfs4_show_fname(s, file);
>         seq_printf(s, " }\n");
>
>         return 0;
> --
> 2.25.3
>


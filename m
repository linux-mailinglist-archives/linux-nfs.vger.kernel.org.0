Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37E6E37FBB8
	for <lists+linux-nfs@lfdr.de>; Thu, 13 May 2021 18:43:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234471AbhEMQoa (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 13 May 2021 12:44:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:23182 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234417AbhEMQo1 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 13 May 2021 12:44:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620924196;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=u4S1WWBl+Kegd6xLD9awLjI+y8LQ2txbSj6xIK9Y9Xg=;
        b=BNJvttZaWtD8IGkyZ/rC8DEzA+TEa5nDeMiQs9BhA93NtVHsiSx7Kk71cYyAq8UvYxXssg
        E/lhaabefnXKs8lIcQvGP4cHjhu8AoWDw0QMbE7fpv8pKo9t2LnCGzvM9a8KBNLy8Hqd5x
        bKAjSP5esGVurEBym9Oib7Az7yzSJCA=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-8-27IB3sCuO8SP40YXtz_XWg-1; Thu, 13 May 2021 12:43:14 -0400
X-MC-Unique: 27IB3sCuO8SP40YXtz_XWg-1
Received: by mail-yb1-f200.google.com with SMTP id c9-20020a2580c90000b02904f86395a96dso26939752ybm.19
        for <linux-nfs@vger.kernel.org>; Thu, 13 May 2021 09:43:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u4S1WWBl+Kegd6xLD9awLjI+y8LQ2txbSj6xIK9Y9Xg=;
        b=B7OgPHWXHJ1Biak8lz7XCJjP+4yukkVLQkJ+jJY3ccxA4I6IHkkOv/sVQ7qD7mLiuX
         d6m+hGk2T+uwdRH9a/30P+Ze8gTZP6hIP5N9Kj4q5JaRuyfJc9DjPWFiJ3VtYoURzF6b
         wSG0GZvik1o6dxGzwBr6pNXbIVjz1rBbx/zaHl7YR4phfQ40vufJNt3mejWjDLzdy6jo
         XITLdDmCowpxnsCeDfQwjOCRtFW3UoM0EVG0sIV2Ig61YCT6w3SK75ssqgv6n1CXSmus
         ndY360CztIrVquSsKRXkZo1Mq3x9xxXmHVsuG1O1uka7Z1yGItWZam7fG/yA3Rukfgz3
         QLvw==
X-Gm-Message-State: AOAM533TyVapJx285uPbtG8Vv6hx+gSCJ2rlw+9QlMUXut5CXtlMQlxw
        Vpl3jdILiQA+CgeC8D3aFS7bAZPMnoGa/y8q8M+yJIMiS57wxpt4tdfedC91urZxfecn5HAZdvh
        b5DHqdsgrqn0NS+JMd9lbsx32WpO6i68wN5Eo
X-Received: by 2002:a25:6557:: with SMTP id z84mr39938013ybb.88.1620924194020;
        Thu, 13 May 2021 09:43:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyXZ/SrUg0yiF0CoRZZ+OR/cTP3uNS4JFWXaiisuVksr+LqjF4uuu/beuZcm4aETmWeeJh9O/1FL9HB7kT4D9Q=
X-Received: by 2002:a25:6557:: with SMTP id z84mr39937985ybb.88.1620924193769;
 Thu, 13 May 2021 09:43:13 -0700 (PDT)
MIME-Version: 1.0
References: <162083366966.3108.12581818416105328952.stgit@klimt.1015granger.net>
 <162083375498.3108.14242612463783055564.stgit@klimt.1015granger.net>
In-Reply-To: <162083375498.3108.14242612463783055564.stgit@klimt.1015granger.net>
From:   David Wysochanski <dwysocha@redhat.com>
Date:   Thu, 13 May 2021 12:42:37 -0400
Message-ID: <CALF+zOkZYg7RzayueKGwFaE-8sHKTB6g4q_Ej-+u=MkH35Dnqw@mail.gmail.com>
Subject: Re: [PATCH v2 09/25] NFSD: Add a couple more nfsd_clid_expired call sites
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>, rostedt@goodmis.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, May 12, 2021 at 11:36 AM Chuck Lever <chuck.lever@oracle.com> wrote:
>
> Improve observation of NFSv4 lease expiry.
>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  fs/nfsd/nfs4state.c |    3 +++
>  1 file changed, 3 insertions(+)
>

How about adding a parameter to explain the location of the expiry to
make it more slightly more readable?
Below is an attempt at the two added here, I think there's one more
not shown though in nfs4_laundromat, which you could just use
"laundromat".

> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 08ff643e96fb..7fa90a3177fa 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -2665,6 +2665,8 @@ static void force_expire_client(struct nfs4_client *clp)
>         struct nfsd_net *nn = net_generic(clp->net, nfsd_net_id);
>         bool already_expired;
>
> +       trace_nfsd_clid_expired(&clp->cl_clientid);
> +

trace_nfsd_clid_expired(..., "admin forced");

>         spin_lock(&clp->cl_lock);
>         clp->cl_time = 0;
>         spin_unlock(&clp->cl_lock);
> @@ -4075,6 +4077,7 @@ nfsd4_setclientid_confirm(struct svc_rqst *rqstp,
>                                 goto out;
>                         status = mark_client_expired_locked(old);
>                         if (status) {
> +                               trace_nfsd_clid_expired(&old->cl_clientid);

trace_nfsd_clid_expired(..., "setclientid_confirm existing"); /* found
an existing confirmed clientid by name */

>                                 old = NULL;
>                                 goto out;
>                         }
>
>


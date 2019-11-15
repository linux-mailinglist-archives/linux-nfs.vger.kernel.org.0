Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7EA19FE606
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Nov 2019 20:51:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbfKOTvw (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 15 Nov 2019 14:51:52 -0500
Received: from mail-vk1-f196.google.com ([209.85.221.196]:34677 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbfKOTvw (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 15 Nov 2019 14:51:52 -0500
Received: by mail-vk1-f196.google.com with SMTP id t184so2641152vka.1;
        Fri, 15 Nov 2019 11:51:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4KiNBsxHheXZNqI4na4gQR3m+5fIhGvAvoCZcEU0Sm4=;
        b=cORSA9FAQ3ZzCjQ3hKNHeY1eWEyzAlRpCRoCTVh531q+T4NEKPvfOh6VFp6WGlEr/0
         CiRMwvF+uAVmPVRSV+Df/th3fQdRT5boEO+MoBjTShJGrGuvzaTermT/wh5oIYfIex7b
         OhBWY2tSWgBRzge7CDapjaasSpTm4KzCvElHefbjcnH3UJW61to7Ktg7vcnR+iS0cQHF
         +hfcfWJCSKUXKNMkZQzoN1PBE3ju5E602kpCkgCCzfJcWEA8anATi74BPJZB6YEvbZ/B
         lb3pcW8S1ZK6fHXO/tl54EOYwZvLwzchqdJ1TBVd7iriKBSGMLEA8w9/YPhymNSqW9R1
         tiEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4KiNBsxHheXZNqI4na4gQR3m+5fIhGvAvoCZcEU0Sm4=;
        b=MvgjWR3jiTxHzeMcF79ytdT1HDZvHtqTmkDNmqDlAjaEd/h2GkJZQT6UvgQtGLxOXA
         dcjxYvEgGc4wsPIJ6Vf+5hN1IZ7dIIcuIDJxq9K4Md78zUyGSir841moVFfTxDad+3lr
         SjndRzGHoUqThsCny/Fp7WNb5ThkHViP+axTkco68OHSmLDOUuyouUmhaoxnhC+kP6OL
         iKBZXWIWv7J35nFFeQxVwRs8y9rhOKttdH/oj734ZgsmLvJbCNPYS2sVwgX40mIXpMb1
         /j+c7fRzqWEO31XpvIWeTDzJpZpyCIZINwMqBdw3w9ddBzqR9dtsIL0fQ/eMVsnxLq+2
         v8rA==
X-Gm-Message-State: APjAAAVRsgZpi6HStmaSXoI0K7wJ3dO8RhAeqzM0ZtymopBo3OjwpFrh
        OqsCRtzuQ+ODXrnhmLF6WE3Mb2ZnOu7ntCkZy7cpEA==
X-Google-Smtp-Source: APXvYqyGNmlj/uh6phuzp+3XatuNCJhbV9TT/NtbLTJ8WC93meU/M4AIXSEpPNRd6PjBxTNcD6+O3ABKs+wZXWwAxt8=
X-Received: by 2002:a1f:5042:: with SMTP id e63mr9737804vkb.98.1573847509090;
 Fri, 15 Nov 2019 11:51:49 -0800 (PST)
MIME-Version: 1.0
References: <c64dfc7b-0c0b-e571-5a49-f32034eccaa5@canonical.com>
In-Reply-To: <c64dfc7b-0c0b-e571-5a49-f32034eccaa5@canonical.com>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Fri, 15 Nov 2019 14:51:38 -0500
Message-ID: <CAN-5tyHsUDJW5r5n84sG-xgUwhp_8psprah1Q1DMdXPT9TxZmA@mail.gmail.com>
Subject: Re: NFS: handle source server reboot
To:     Colin Ian King <colin.king@canonical.com>
Cc:     Olga Kornievskaia <kolga@netapp.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        linux-nfs <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Nov 15, 2019 at 5:06 AM Colin Ian King <colin.king@canonical.com> wrote:
>
> Hi,
>
> Static analysis with Coverity has detected a memory leak in the
> following commit:
>
> commit 0e65a32c8a569db363048e17a708b1a0913adbef
> Author: Olga Kornievskaia <kolga@netapp.com>
> Date:   Fri Jun 14 14:38:40 2019 -0400
>
>     NFS: handle source server reboot
>
> In function __nfs4_copy_file_range() in fs/nfs/nfs4file.c, analysis is
> as follows:
>
>
> 155retry:
>    5. Condition !nfs42_files_from_same_server(file_in, file_out), taking
> false branch.
>    9. Condition !nfs42_files_from_same_server(file_in, file_out), taking
> false branch.
>
> 156        if (!nfs42_files_from_same_server(file_in, file_out)) {
> 157                /* for inter copy, if copy size if smaller than 12 RPC
> 158                 * payloads, fallback to traditional copy. There are
> 159                 * 14 RPCs during an NFSv4.x mount between source/dest
> 160                 * servers.
> 161                 */
> 162                if (sync ||
> 163                        count <= 14 *
> NFS_SERVER(file_inode(file_in))->rsize)
> 164                        return -EOPNOTSUPP;
> 165                cn_resp = kzalloc(sizeof(struct nfs42_copy_notify_res),
> 166                                GFP_NOFS);
> 167                if (unlikely(cn_resp == NULL))
> 168                        return -ENOMEM;
> 169
> 170                ret = nfs42_proc_copy_notify(file_in, file_out, cn_resp);
> 171                if (ret) {
> 172                        ret = -EOPNOTSUPP;
> 173                        goto out;
> 174                }
> 175                nss = &cn_resp->cnr_src;
> 176                cnrs = &cn_resp->cnr_stateid;
> 177        }
> 178        ret = nfs42_proc_copy(file_in, pos_in, file_out, pos_out, count,
> 179                                nss, cnrs, sync);
> 180out:
>    6. freed_arg: kfree frees cn_resp.
>
>    CID 91571 (#1 of 1): Double free (USE_AFTER_FREE)10. double_free:
> Calling kfree frees pointer cn_resp which has already been freed.
>
> 181        kfree(cn_resp);
>
>    7. Condition ret == -11, taking true branch.
>
> 182        if (ret == -EAGAIN)
>    8. Jumping to label retry.
>
> 183                goto retry;
> 184        return ret;
> 185}
> 186
>
> On the 2nd iteration of the retry loop, cn_resp is being free'd twice if
> the call to nfs42_files_from_same_server() returns zero since cn_resp is
> not kalloc'd in the 2nd iteration. A naive fix would be to set cn_resp
> to NULL after the kfree on line 181, but I'm not sure if there is a
> better way to resolve this.
>

If a definition of double free include freeing a null pointer twice,
then I agree this is a valid catch. Cases are when servers are the
same kfree(cn_resp) is called with a null argument and if retried will
be called with a null argument again (since kfree doesn't care about
null it shouldn't be a problem). If servers are not the same, then
memory is allocated then freed then allocated again. When code is
re-executed (on retry), it's not possible for condition to change from
servers being same or different.

I'll send a patch that conditions the kfree() to only when it was
allocated. Hopefully, it won't trip the analysis that way.

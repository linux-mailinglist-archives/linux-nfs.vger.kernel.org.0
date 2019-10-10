Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2DE36D2FA5
	for <lists+linux-nfs@lfdr.de>; Thu, 10 Oct 2019 19:33:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726781AbfJJRdD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 10 Oct 2019 13:33:03 -0400
Received: from mail-vk1-f193.google.com ([209.85.221.193]:38297 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbfJJRdC (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 10 Oct 2019 13:33:02 -0400
Received: by mail-vk1-f193.google.com with SMTP id s72so1537582vkh.5
        for <linux-nfs@vger.kernel.org>; Thu, 10 Oct 2019 10:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9yknvV/GENoppj7xg7obS1pC6L3clCi+a4lb4JyhtyE=;
        b=DrRmy8dCwcLmj7059rmF/a1wMYRGVJyJCU4Tur+paLoxbb95hD3w6oTe/ARHJtTjXj
         ozvLbmjgmy1R532rU874d3F9nDcDj4wa//GRe8ExAGiBHZF7b+gStVtzbcszdI9jELET
         x42zjTcCVn5Ynbjbhqh7p7CwtM67l65d/vx2NUhOz3OWXsjBz83StENorRjZv5SMRqMi
         s21gGPE5AhlVXq051y63JHvRGvl4hRERwbdkdHVEMNidNzLxRGPMKyl6ZRB7e9iF2MPU
         llkHmBj5LGvQKQbfIjo/fnmkqrq8ocP+HsB9610ceaZwuNo8S0+8Zo58i9QGTJ++ugtN
         +dlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9yknvV/GENoppj7xg7obS1pC6L3clCi+a4lb4JyhtyE=;
        b=YkKjpOVAWB4TAS0bqetLihYKs43H6ZoA5BBDJjabGPLyEQEJWe6T+EmOE1DT4eaSVz
         HyIXg6u4qbcRD4XAPoCulfig16uI9xOn24Rlv0q0addKPuWL5KAVsft4cahuAVE9UlSh
         YEePtmcARAzg44dCYjLeUFV6ZSDkYkSQrrCyOOwQopBCWXOXR8bkeTEbbOub7pclpEO3
         lNlGDGiBziEZPPhYTmWoxWN1KYVAx/TXLc4rtWs1szM8KDbqqMy2JkpEVZ/4X7PBdjf7
         rR1TS4KjRf2foaeM1OnmY3rFknhhtRjsG05YfQuRjgzmh0qQY40fpr0q5CZ39y+Nqf86
         Y10g==
X-Gm-Message-State: APjAAAUEbIYIDu8aHCOVQ55XwplvZVIXNbdN+SN4vFcxQccSZhn/wJyl
        mMpbthy6I+y6ncbBBaCSEmjuzf8bL28Hw0P0pBE=
X-Google-Smtp-Source: APXvYqxKhvXQTeYmrQDD5jUnOJhuxQ1noJd0IckFPYUpO9ODNpn4rQwOJZHTWZGMmCP0rQA3oHejSrfw3bZ4XlfRGrw=
X-Received: by 2002:a1f:4e45:: with SMTP id c66mr6237292vkb.72.1570728781484;
 Thu, 10 Oct 2019 10:33:01 -0700 (PDT)
MIME-Version: 1.0
References: <20191010074020.o2uwtuyegtmfdlze@XZHOUW.usersys.redhat.com>
In-Reply-To: <20191010074020.o2uwtuyegtmfdlze@XZHOUW.usersys.redhat.com>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Thu, 10 Oct 2019 13:32:50 -0400
Message-ID: <CAN-5tyGKNFsxQHne4hFhON1VRZzCkUjwFMX3ZuzfLASgEN0pMw@mail.gmail.com>
Subject: Re: [PATCH] NFSv4: fix stateid refreshing when CLOSE racing with OPEN
To:     Murphy Zhou <jencce.kernel@gmail.com>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>,
        Trond Myklebust <trondmy@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Oct 10, 2019 at 3:42 AM Murphy Zhou <jencce.kernel@gmail.com> wrote:
>
> Since commit:
>   [0e0cb35] NFSv4: Handle NFS4ERR_OLD_STATEID in CLOSE/OPEN_DOWNGRADE
>
> xfstests generic/168 on v4.2 starts to fail because reflink call gets:
>   +XFS_IOC_CLONE_RANGE: Resource temporarily unavailable

I don't believe this failure has to do with getting ERR_OLD_STATEID on
the CLOSE. What you see on the network trace is expected as the client
in parallel sends OPEN/CLOSE thus server will fail the CLOSE with the
ERR_OLD_STATEID since it already updated its stateid for the OPEN.

> In tshark output, NFS4ERR_OLD_STATEID stands out when comparing with
> good ones:
>
>  5210   NFS 406 V4 Reply (Call In 5209) OPEN StateID: 0xadb5
>  5211   NFS 314 V4 Call GETATTR FH: 0x8d44a6b1
>  5212   NFS 250 V4 Reply (Call In 5211) GETATTR
>  5213   NFS 314 V4 Call GETATTR FH: 0x8d44a6b1
>  5214   NFS 250 V4 Reply (Call In 5213) GETATTR
>  5216   NFS 422 V4 Call WRITE StateID: 0xa818 Offset: 851968 Len: 65536
>  5218   NFS 266 V4 Reply (Call In 5216) WRITE
>  5219   NFS 382 V4 Call OPEN DH: 0x8d44a6b1/
>  5220   NFS 338 V4 Call CLOSE StateID: 0xadb5
>  5222   NFS 406 V4 Reply (Call In 5219) OPEN StateID: 0xa342
>  5223   NFS 250 V4 Reply (Call In 5220) CLOSE Status: NFS4ERR_OLD_STATEID
>  5225   NFS 338 V4 Call CLOSE StateID: 0xa342
>  5226   NFS 314 V4 Call GETATTR FH: 0x8d44a6b1
>  5227   NFS 266 V4 Reply (Call In 5225) CLOSE
>  5228   NFS 250 V4 Reply (Call In 5226) GETATTR

"resource temporarily unavailable" is more likely to do with ulimit limits.

I also saw the same error. After I increased the ulimit for the stack
size, the problem went away. There might still be a problem somewhere
in the kernel.

Trond, is it possible that we have too many CLOSE recovery on the
stack that's eating up stack space?

> It's easy to reproduce. By printing some logs, found that we are making
> CLOSE seqid larger then OPEN seqid when racing.
>
> Fix this by not bumping seqid when it's equal to OPEN seqid. Also
> put the whole changing process into seqlock read protection in case
> really bad luck, and this is the same locking behavior with the
> old deleted function.
>
> Fixes: 0e0cb35b417f ("NFSv4: Handle NFS4ERR_OLD_STATEID in CLOSE/OPEN_DOWNGRADE")
> Signed-off-by: Murphy Zhou <jencce.kernel@gmail.com>
> ---
>  fs/nfs/nfs4proc.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
>
> diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
> index 11eafcf..6db5a09 100644
> --- a/fs/nfs/nfs4proc.c
> +++ b/fs/nfs/nfs4proc.c
> @@ -3334,12 +3334,13 @@ static void nfs4_sync_open_stateid(nfs4_stateid *dst,
>                         break;
>                 }
>                 seqid_open = state->open_stateid.seqid;
> -               if (read_seqretry(&state->seqlock, seq))
> -                       continue;
>
>                 dst_seqid = be32_to_cpu(dst->seqid);
>                 if ((s32)(dst_seqid - be32_to_cpu(seqid_open)) < 0)
>                         dst->seqid = seqid_open;
> +
> +               if (read_seqretry(&state->seqlock, seq))
> +                       continue;
>                 break;
>         }
>  }
> @@ -3367,14 +3368,16 @@ static bool nfs4_refresh_open_old_stateid(nfs4_stateid *dst,
>                         break;
>                 }
>                 seqid_open = state->open_stateid.seqid;
> -               if (read_seqretry(&state->seqlock, seq))
> -                       continue;
>
>                 dst_seqid = be32_to_cpu(dst->seqid);
> -               if ((s32)(dst_seqid - be32_to_cpu(seqid_open)) >= 0)
> +               if ((s32)(dst_seqid - be32_to_cpu(seqid_open)) > 0)
>                         dst->seqid = cpu_to_be32(dst_seqid + 1);
>                 else
>                         dst->seqid = seqid_open;
> +
> +               if (read_seqretry(&state->seqlock, seq))
> +                       continue;
> +
>                 ret = true;
>                 break;
>         }
> --
> 1.8.3.1
>

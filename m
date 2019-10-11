Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 452C2D3C92
	for <lists+linux-nfs@lfdr.de>; Fri, 11 Oct 2019 11:43:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727036AbfJKJnC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 11 Oct 2019 05:43:02 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44603 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726585AbfJKJnC (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 11 Oct 2019 05:43:02 -0400
Received: by mail-pl1-f193.google.com with SMTP id q15so4205580pll.11
        for <linux-nfs@vger.kernel.org>; Fri, 11 Oct 2019 02:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5pr4A0aeEXs2QDx84SWPk1tfkOk1t+EeOP5HxeEIp/g=;
        b=CagmAsG1uTrir6P0c9MCPGScKIHsTUvSPq5gjcuVs6hIUiBTftXVejrnUQxUabwLrM
         pvQU2tS6+r9X6YWP+uadX/+xvnxfyMmbMbm769Cn214Z0E6TQGhg1vyS743eBktJnc67
         C9W1nZNxPcjU/elfcjmOSpBQ9HQ2dvUYbecwmuG0NGbA47Zpg8tGdznY+MVADoqXEHQI
         P7INVot7xe9S5PPds+7Tf3tmHh4qOwBsLE03lYt90RUfetrqDnkwfJmssfFEnD6L+30x
         1v7znBO2ExbbRRuRGhysaPdfiFmE3SnUHJKDEu0j/ayTIEciOM80svYbdzxbpqKJNMzZ
         Lumg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5pr4A0aeEXs2QDx84SWPk1tfkOk1t+EeOP5HxeEIp/g=;
        b=SS4pFfyGDfbSa3ju5ByOAiOSHjDRtw6QAI7cv8ueJieh9WJcFlly0/t8wzm/972tRz
         wW2fDTw1aimjus+C6SXANWeN199ali6ISz9KVkEzJ+0ZRMARujzgt/thwV/WOVgX0Sim
         qPSWA3BxVXSsiVZjcsBXwFNLdW1/4qECUa12cgztWJfHUZ/9Rc8XdT4xM6Oc6Q/WKm6g
         1BpC83Z8YKMeLo655CvBcHubLbO54YSRskGTIUu+P3EQizQT3WxY9wxSRLtUYEi6gcOE
         Agn7Ta451O6ZNy1X2QER3+3tj9aE6uYlxmHbRqHyMI1XUvKg/7X1czrRpr0LVkkZIkLF
         b1EA==
X-Gm-Message-State: APjAAAU/657XQ+34VBiJzGZxBaFJTkmpC4ZiVE9VUGsLX3qlSRZQInHI
        Rz3+S6eElKajL7MaRdZcCO8=
X-Google-Smtp-Source: APXvYqxLPHI4uBqNFoQFDnsrzvFTIJOnB2p8B9xMXKwUy3NMOo/hjyquaBVFPY99dRTJbRcJOqwBjw==
X-Received: by 2002:a17:902:76ca:: with SMTP id j10mr13386862plt.51.1570786981503;
        Fri, 11 Oct 2019 02:43:01 -0700 (PDT)
Received: from localhost ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id c8sm12061586pfi.117.2019.10.11.02.43.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2019 02:43:00 -0700 (PDT)
Date:   Fri, 11 Oct 2019 17:42:53 +0800
From:   Murphy Zhou <jencce.kernel@gmail.com>
To:     Olga Kornievskaia <aglo@umich.edu>
Cc:     Murphy Zhou <jencce.kernel@gmail.com>,
        linux-nfs <linux-nfs@vger.kernel.org>,
        Trond Myklebust <trondmy@gmail.com>
Subject: Re: [PATCH] NFSv4: fix stateid refreshing when CLOSE racing with OPEN
Message-ID: <20191011094253.yjwncvqv4cnq7wpn@xzhoux.usersys.redhat.com>
References: <20191010074020.o2uwtuyegtmfdlze@XZHOUW.usersys.redhat.com>
 <CAN-5tyGKNFsxQHne4hFhON1VRZzCkUjwFMX3ZuzfLASgEN0pMw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAN-5tyGKNFsxQHne4hFhON1VRZzCkUjwFMX3ZuzfLASgEN0pMw@mail.gmail.com>
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Oct 10, 2019 at 01:32:50PM -0400, Olga Kornievskaia wrote:
> On Thu, Oct 10, 2019 at 3:42 AM Murphy Zhou <jencce.kernel@gmail.com> wrote:
> >
> > Since commit:
> >   [0e0cb35] NFSv4: Handle NFS4ERR_OLD_STATEID in CLOSE/OPEN_DOWNGRADE
> >
> > xfstests generic/168 on v4.2 starts to fail because reflink call gets:
> >   +XFS_IOC_CLONE_RANGE: Resource temporarily unavailable
> 
> I don't believe this failure has to do with getting ERR_OLD_STATEID on
> the CLOSE. What you see on the network trace is expected as the client
> in parallel sends OPEN/CLOSE thus server will fail the CLOSE with the
> ERR_OLD_STATEID since it already updated its stateid for the OPEN.
> 
> > In tshark output, NFS4ERR_OLD_STATEID stands out when comparing with
> > good ones:
> >
> >  5210   NFS 406 V4 Reply (Call In 5209) OPEN StateID: 0xadb5
> >  5211   NFS 314 V4 Call GETATTR FH: 0x8d44a6b1
> >  5212   NFS 250 V4 Reply (Call In 5211) GETATTR
> >  5213   NFS 314 V4 Call GETATTR FH: 0x8d44a6b1
> >  5214   NFS 250 V4 Reply (Call In 5213) GETATTR
> >  5216   NFS 422 V4 Call WRITE StateID: 0xa818 Offset: 851968 Len: 65536
> >  5218   NFS 266 V4 Reply (Call In 5216) WRITE
> >  5219   NFS 382 V4 Call OPEN DH: 0x8d44a6b1/
> >  5220   NFS 338 V4 Call CLOSE StateID: 0xadb5
> >  5222   NFS 406 V4 Reply (Call In 5219) OPEN StateID: 0xa342
> >  5223   NFS 250 V4 Reply (Call In 5220) CLOSE Status: NFS4ERR_OLD_STATEID
> >  5225   NFS 338 V4 Call CLOSE StateID: 0xa342
> >  5226   NFS 314 V4 Call GETATTR FH: 0x8d44a6b1
> >  5227   NFS 266 V4 Reply (Call In 5225) CLOSE
> >  5228   NFS 250 V4 Reply (Call In 5226) GETATTR
> 
> "resource temporarily unavailable" is more likely to do with ulimit limits.
> 
> I also saw the same error. After I increased the ulimit for the stack
> size, the problem went away. There might still be a problem somewhere
> in the kernel.

Do you mean ulimit -s ? I set it to 'unlimited' and still can reproduce
this.

Thanks,
M
> 
> Trond, is it possible that we have too many CLOSE recovery on the
> stack that's eating up stack space?
> 
> > It's easy to reproduce. By printing some logs, found that we are making
> > CLOSE seqid larger then OPEN seqid when racing.
> >
> > Fix this by not bumping seqid when it's equal to OPEN seqid. Also
> > put the whole changing process into seqlock read protection in case
> > really bad luck, and this is the same locking behavior with the
> > old deleted function.
> >
> > Fixes: 0e0cb35b417f ("NFSv4: Handle NFS4ERR_OLD_STATEID in CLOSE/OPEN_DOWNGRADE")
> > Signed-off-by: Murphy Zhou <jencce.kernel@gmail.com>
> > ---
> >  fs/nfs/nfs4proc.c | 13 ++++++++-----
> >  1 file changed, 8 insertions(+), 5 deletions(-)
> >
> > diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
> > index 11eafcf..6db5a09 100644
> > --- a/fs/nfs/nfs4proc.c
> > +++ b/fs/nfs/nfs4proc.c
> > @@ -3334,12 +3334,13 @@ static void nfs4_sync_open_stateid(nfs4_stateid *dst,
> >                         break;
> >                 }
> >                 seqid_open = state->open_stateid.seqid;
> > -               if (read_seqretry(&state->seqlock, seq))
> > -                       continue;
> >
> >                 dst_seqid = be32_to_cpu(dst->seqid);
> >                 if ((s32)(dst_seqid - be32_to_cpu(seqid_open)) < 0)
> >                         dst->seqid = seqid_open;
> > +
> > +               if (read_seqretry(&state->seqlock, seq))
> > +                       continue;
> >                 break;
> >         }
> >  }
> > @@ -3367,14 +3368,16 @@ static bool nfs4_refresh_open_old_stateid(nfs4_stateid *dst,
> >                         break;
> >                 }
> >                 seqid_open = state->open_stateid.seqid;
> > -               if (read_seqretry(&state->seqlock, seq))
> > -                       continue;
> >
> >                 dst_seqid = be32_to_cpu(dst->seqid);
> > -               if ((s32)(dst_seqid - be32_to_cpu(seqid_open)) >= 0)
> > +               if ((s32)(dst_seqid - be32_to_cpu(seqid_open)) > 0)
> >                         dst->seqid = cpu_to_be32(dst_seqid + 1);
> >                 else
> >                         dst->seqid = seqid_open;
> > +
> > +               if (read_seqretry(&state->seqlock, seq))
> > +                       continue;
> > +
> >                 ret = true;
> >                 break;
> >         }
> > --
> > 1.8.3.1
> >

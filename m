Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7500F3D75C
	for <lists+linux-nfs@lfdr.de>; Tue, 11 Jun 2019 22:00:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406013AbfFKUA2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 11 Jun 2019 16:00:28 -0400
Received: from mail-vk1-f194.google.com ([209.85.221.194]:44554 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405168AbfFKUA2 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 11 Jun 2019 16:00:28 -0400
Received: by mail-vk1-f194.google.com with SMTP id x129so2761734vkc.11;
        Tue, 11 Jun 2019 13:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aYJZFpjNbJ0X77+jjPplVCyD9rqVt7UHJYGdl0VXVGM=;
        b=kFkJlfd+Th5bSHbTt8jV+Usr+fADIyW6aKRqPc/ipjJDPqHKixM6k2xmKwHGKEaBVT
         goTcTRgV6mTX32o6tYldQabvUu779mX5hrJBPs+rcstHcpmEp5ySTht4pyE/KUrC00dd
         ELbnlTWYr6af3h40/2ku4d4GzFbXK5jCtCK/BhORhfWpfdVZONNgWizvx1zFrYT45bLe
         S7+tcg7pIG1O5T8oxj1Csc0H/AJGMTlsmurgWlGQyL4Hm0O8adtZTFsiinh6YJ/V6tex
         f9I9hdvIIConrIkYGQgrdpO7f7mWDP3UXUJDmqKedJQQWCoxr+ZlHFci4pbGWPfWE/1n
         Qqpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aYJZFpjNbJ0X77+jjPplVCyD9rqVt7UHJYGdl0VXVGM=;
        b=QHSos4jxqjClV1jPqSK87gSY6eEHY0tgnCPynwmkLMFYTlDzk2pBB4Y0bKIOcS1BjG
         6xBixPtxvdWc/IQbKS0aXgj8GOcuNs22BJtg2Pnp8T6/Kk9IwmcgUHLT+wCHiuk+r00w
         2U7sfhfyTw0wIbu9T1umxSPZvl7+TcYZCv3n8YDHDnQdWT4b5xDbJH4nbf4GuzuVytRj
         bTBAZHh6iDke2Ernqly3Y/BdjTX9uv5vdlOsGYjSJF80YT3NvG267f2LScb6BXwKb1PM
         tZrYAfQekX2VAFqQgpDe82/qqYc2fHbHfVLuxM9WJRPeDq1lpGyWq4A6Rrrs1s8uZNsd
         /qNA==
X-Gm-Message-State: APjAAAWwNH8GLa9R0MHz1AYu8u1CUJNAftRWuFuSmXUPqZAwcnPxZjn9
        UIjckgTPlwbG7mrhPYGQx97B6qnAaTcI2Dab5RQ0twKn
X-Google-Smtp-Source: APXvYqyeScaa/Ogt2AktuTIH4ScLkNDPCXwuiwNWuFV6hbel7oEZVsbWcSyuMFH/TZ8RSevfvOpzk5KRrE9c6fX+zUM=
X-Received: by 2002:a1f:8d0b:: with SMTP id p11mr14620525vkd.31.1560283224593;
 Tue, 11 Jun 2019 13:00:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190611150445.2877.8656.stgit@manet.1015granger.net>
 <20190611150923.2877.6862.stgit@manet.1015granger.net> <CAN-5tyHx-r6c6RgHk2ocv2CxTgw_8Ebie_fUUSxzaVKotmX1zw@mail.gmail.com>
 <C5542119-E526-4A69-9D15-B0EDEFF1E5A9@oracle.com>
In-Reply-To: <C5542119-E526-4A69-9D15-B0EDEFF1E5A9@oracle.com>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Tue, 11 Jun 2019 16:00:13 -0400
Message-ID: <CAN-5tyHW4L8_djraOPfoLx=NorqgHOijjaApWNNESVRO2X9Upg@mail.gmail.com>
Subject: Re: [PATCH v2 16/19] NFS: Fix show_nfs_errors macros again
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-rdma <linux-rdma@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Jun 11, 2019 at 3:37 PM Chuck Lever <chuck.lever@oracle.com> wrote:
>
>
>
> > On Jun 11, 2019, at 3:33 PM, Olga Kornievskaia <aglo@umich.edu> wrote:
> >
> > On Tue, Jun 11, 2019 at 11:09 AM Chuck Lever <chuck.lever@oracle.com> wrote:
> >>
> >> I noticed that NFS status values stopped working again.
> >>
> >> trace_print_symbols_seq() takes an unsigned long. Passing a negative
> >> errno or negative NFSERR value just confuses it, and since we're
> >> using C macros here and not static inline functions, all bets are
> >> off due to implicit type casting.
> >>
> >> Straight-line the calling conventions so that error codes are stored
> >> in the trace record as positive values in an unsigned long field.
> >>
> >> It's often the case that an error value that is positive is a byte
> >> count but when it's negative, it's an error (e.g. nfs4_write). Fix
> >> those cases so that the value that is eventually stored in the
> >> error field is a positive NFS status or errno, or zero.
> >>
> >
> > Hi Chuck,
> >
> > To clarify, so on error case, we no longer going be seeing a negative
> > value so error=-5 (EIO) would be error=5 (EIO)? I have always relied
> > on searching for "error=-" thru the trace_pipe log for errors. Do we
> > really need to change that?
>
> error= will be zero or a positive errno/status code. If the trace point
> has a count= or task->tk_status= you can see the byte count when
> error=0.
>
> So now the search will be for anything that has "error=" but is not
> "error=0".

Unfortunately, "error=" but not "error=0" isn't easily translated into
the vi search... ("error=-" was more convenient).

Can we keep the value of the error= negative but change it to the
positive value for the show_nfsv4_errors()?

> >> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> >> ---
> >> fs/nfs/nfs4trace.h |  120 ++++++++++++++++++++++++++--------------------------
> >> 1 file changed, 60 insertions(+), 60 deletions(-)
> >>
> >> diff --git a/fs/nfs/nfs4trace.h b/fs/nfs/nfs4trace.h
> >> index 6beb1f2..9a01731 100644
> >> --- a/fs/nfs/nfs4trace.h
> >> +++ b/fs/nfs/nfs4trace.h
> >> @@ -156,7 +156,7 @@
> >> TRACE_DEFINE_ENUM(NFS4ERR_XDEV);
> >>
> >> #define show_nfsv4_errors(error) \
> >> -       __print_symbolic(-(error), \
> >> +       __print_symbolic(error, \
> >>                { NFS4_OK, "OK" }, \
> >>                /* Mapped by nfs4_stat_to_errno() */ \
> >>                { EPERM, "EPERM" }, \
> >> @@ -348,7 +348,7 @@
> >>
> >>                TP_STRUCT__entry(
> >>                        __string(dstaddr, clp->cl_hostname)
> >> -                       __field(int, error)
> >> +                       __field(unsigned long, error)
> >>                ),
> >>
> >>                TP_fast_assign(
> >> @@ -357,7 +357,7 @@
> >>                ),
> >>
> >>                TP_printk(
> >> -                       "error=%d (%s) dstaddr=%s",
> >> +                       "error=%lu (%s) dstaddr=%s",
> >>                        __entry->error,
> >>                        show_nfsv4_errors(__entry->error),
> >>                        __get_str(dstaddr)
> >> @@ -420,7 +420,7 @@
> >>                        __field(unsigned int, highest_slotid)
> >>                        __field(unsigned int, target_highest_slotid)
> >>                        __field(unsigned int, status_flags)
> >> -                       __field(int, error)
> >> +                       __field(unsigned long, error)
> >>                ),
> >>
> >>                TP_fast_assign(
> >> @@ -435,7 +435,7 @@
> >>                        __entry->error = res->sr_status;
> >>                ),
> >>                TP_printk(
> >> -                       "error=%d (%s) session=0x%08x slot_nr=%u seq_nr=%u "
> >> +                       "error=%lu (%s) session=0x%08x slot_nr=%u seq_nr=%u "
> >>                        "highest_slotid=%u target_highest_slotid=%u "
> >>                        "status_flags=%u (%s)",
> >>                        __entry->error,
> >> @@ -467,7 +467,7 @@
> >>                        __field(unsigned int, seq_nr)
> >>                        __field(unsigned int, highest_slotid)
> >>                        __field(unsigned int, cachethis)
> >> -                       __field(int, error)
> >> +                       __field(unsigned long, error)
> >>                ),
> >>
> >>                TP_fast_assign(
> >> @@ -476,11 +476,11 @@
> >>                        __entry->seq_nr = args->csa_sequenceid;
> >>                        __entry->highest_slotid = args->csa_highestslotid;
> >>                        __entry->cachethis = args->csa_cachethis;
> >> -                       __entry->error = -be32_to_cpu(status);
> >> +                       __entry->error = be32_to_cpu(status);
> >>                ),
> >>
> >>                TP_printk(
> >> -                       "error=%d (%s) session=0x%08x slot_nr=%u seq_nr=%u "
> >> +                       "error=%lu (%s) session=0x%08x slot_nr=%u seq_nr=%u "
> >>                        "highest_slotid=%u",
> >>                        __entry->error,
> >>                        show_nfsv4_errors(__entry->error),
> >> @@ -504,7 +504,7 @@
> >>                        __field(unsigned int, seq_nr)
> >>                        __field(unsigned int, highest_slotid)
> >>                        __field(unsigned int, cachethis)
> >> -                       __field(int, error)
> >> +                       __field(unsigned long, error)
> >>                ),
> >>
> >>                TP_fast_assign(
> >> @@ -513,11 +513,11 @@
> >>                        __entry->seq_nr = args->csa_sequenceid;
> >>                        __entry->highest_slotid = args->csa_highestslotid;
> >>                        __entry->cachethis = args->csa_cachethis;
> >> -                       __entry->error = -be32_to_cpu(status);
> >> +                       __entry->error = be32_to_cpu(status);
> >>                ),
> >>
> >>                TP_printk(
> >> -                       "error=%d (%s) session=0x%08x slot_nr=%u seq_nr=%u "
> >> +                       "error=%lu (%s) session=0x%08x slot_nr=%u seq_nr=%u "
> >>                        "highest_slotid=%u",
> >>                        __entry->error,
> >>                        show_nfsv4_errors(__entry->error),
> >> @@ -572,18 +572,18 @@
> >>
> >>                TP_STRUCT__entry(
> >>                        __field(u32, op)
> >> -                       __field(int, error)
> >> +                       __field(unsigned long, error)
> >>                ),
> >>
> >>                TP_fast_assign(
> >>                        __entry->op = op;
> >> -                       __entry->error = -error;
> >> +                       __entry->error = error;
> >>                ),
> >>
> >>                TP_printk(
> >> -                       "operation %d: nfs status %d (%s)",
> >> -                       __entry->op,
> >> -                       __entry->error, show_nfsv4_errors(__entry->error)
> >> +                       "error=%lu (%s) operation %d:",
> >> +                       __entry->error, show_nfsv4_errors(__entry->error),
> >> +                       __entry->op
> >>                )
> >> );
> >>
> >> @@ -597,7 +597,7 @@
> >>                TP_ARGS(ctx, flags, error),
> >>
> >>                TP_STRUCT__entry(
> >> -                       __field(int, error)
> >> +                       __field(unsigned long, error)
> >>                        __field(unsigned int, flags)
> >>                        __field(unsigned int, fmode)
> >>                        __field(dev_t, dev)
> >> @@ -615,7 +615,7 @@
> >>                        const struct nfs4_state *state = ctx->state;
> >>                        const struct inode *inode = NULL;
> >>
> >> -                       __entry->error = error;
> >> +                       __entry->error = -error;
> >>                        __entry->flags = flags;
> >>                        __entry->fmode = (__force unsigned int)ctx->mode;
> >>                        __entry->dev = ctx->dentry->d_sb->s_dev;
> >> @@ -647,7 +647,7 @@
> >>                ),
> >>
> >>                TP_printk(
> >> -                       "error=%d (%s) flags=%d (%s) fmode=%s "
> >> +                       "error=%lu (%s) flags=%d (%s) fmode=%s "
> >>                        "fileid=%02x:%02x:%llu fhandle=0x%08x "
> >>                        "name=%02x:%02x:%llu/%s stateid=%d:0x%08x "
> >>                        "openstateid=%d:0x%08x",
> >> @@ -733,7 +733,7 @@
> >>                        __field(u32, fhandle)
> >>                        __field(u64, fileid)
> >>                        __field(unsigned int, fmode)
> >> -                       __field(int, error)
> >> +                       __field(unsigned long, error)
> >>                        __field(int, stateid_seq)
> >>                        __field(u32, stateid_hash)
> >>                ),
> >> @@ -753,7 +753,7 @@
> >>                ),
> >>
> >>                TP_printk(
> >> -                       "error=%d (%s) fmode=%s fileid=%02x:%02x:%llu "
> >> +                       "error=%lu (%s) fmode=%s fileid=%02x:%02x:%llu "
> >>                        "fhandle=0x%08x openstateid=%d:0x%08x",
> >>                        __entry->error,
> >>                        show_nfsv4_errors(__entry->error),
> >> @@ -795,7 +795,7 @@
> >>                TP_ARGS(request, state, cmd, error),
> >>
> >>                TP_STRUCT__entry(
> >> -                       __field(int, error)
> >> +                       __field(unsigned long, error)
> >>                        __field(int, cmd)
> >>                        __field(char, type)
> >>                        __field(loff_t, start)
> >> @@ -825,7 +825,7 @@
> >>                ),
> >>
> >>                TP_printk(
> >> -                       "error=%d (%s) cmd=%s:%s range=%lld:%lld "
> >> +                       "error=%lu (%s) cmd=%s:%s range=%lld:%lld "
> >>                        "fileid=%02x:%02x:%llu fhandle=0x%08x "
> >>                        "stateid=%d:0x%08x",
> >>                        __entry->error,
> >> @@ -865,7 +865,7 @@
> >>                TP_ARGS(request, state, lockstateid, cmd, error),
> >>
> >>                TP_STRUCT__entry(
> >> -                       __field(int, error)
> >> +                       __field(unsigned long, error)
> >>                        __field(int, cmd)
> >>                        __field(char, type)
> >>                        __field(loff_t, start)
> >> @@ -901,7 +901,7 @@
> >>                ),
> >>
> >>                TP_printk(
> >> -                       "error=%d (%s) cmd=%s:%s range=%lld:%lld "
> >> +                       "error=%lu (%s) cmd=%s:%s range=%lld:%lld "
> >>                        "fileid=%02x:%02x:%llu fhandle=0x%08x "
> >>                        "stateid=%d:0x%08x lockstateid=%d:0x%08x",
> >>                        __entry->error,
> >> @@ -970,7 +970,7 @@
> >>                TP_STRUCT__entry(
> >>                        __field(dev_t, dev)
> >>                        __field(u32, fhandle)
> >> -                       __field(int, error)
> >> +                       __field(unsigned long, error)
> >>                        __field(int, stateid_seq)
> >>                        __field(u32, stateid_hash)
> >>                ),
> >> @@ -986,7 +986,7 @@
> >>                ),
> >>
> >>                TP_printk(
> >> -                       "error=%d (%s) dev=%02x:%02x fhandle=0x%08x "
> >> +                       "error=%lu (%s) dev=%02x:%02x fhandle=0x%08x "
> >>                        "stateid=%d:0x%08x",
> >>                        __entry->error,
> >>                        show_nfsv4_errors(__entry->error),
> >> @@ -1007,7 +1007,7 @@
> >>                TP_ARGS(state, lsp, error),
> >>
> >>                TP_STRUCT__entry(
> >> -                       __field(int, error)
> >> +                       __field(unsigned long, error)
> >>                        __field(dev_t, dev)
> >>                        __field(u32, fhandle)
> >>                        __field(u64, fileid)
> >> @@ -1029,7 +1029,7 @@
> >>                ),
> >>
> >>                TP_printk(
> >> -                       "error=%d (%s) fileid=%02x:%02x:%llu fhandle=0x%08x "
> >> +                       "error=%lu (%s) fileid=%02x:%02x:%llu fhandle=0x%08x "
> >>                        "stateid=%d:0x%08x",
> >>                        __entry->error,
> >>                        show_nfsv4_errors(__entry->error),
> >> @@ -1064,7 +1064,7 @@
> >>
> >>                TP_STRUCT__entry(
> >>                        __field(dev_t, dev)
> >> -                       __field(int, error)
> >> +                       __field(unsigned long, error)
> >>                        __field(u64, dir)
> >>                        __string(name, name->name)
> >>                ),
> >> @@ -1072,12 +1072,12 @@
> >>                TP_fast_assign(
> >>                        __entry->dev = dir->i_sb->s_dev;
> >>                        __entry->dir = NFS_FILEID(dir);
> >> -                       __entry->error = error;
> >> +                       __entry->error = -error;
> >>                        __assign_str(name, name->name);
> >>                ),
> >>
> >>                TP_printk(
> >> -                       "error=%d (%s) name=%02x:%02x:%llu/%s",
> >> +                       "error=%lu (%s) name=%02x:%02x:%llu/%s",
> >>                        __entry->error,
> >>                        show_nfsv4_errors(__entry->error),
> >>                        MAJOR(__entry->dev), MINOR(__entry->dev),
> >> @@ -1114,7 +1114,7 @@
> >>                TP_STRUCT__entry(
> >>                        __field(dev_t, dev)
> >>                        __field(u64, ino)
> >> -                       __field(int, error)
> >> +                       __field(unsigned long, error)
> >>                ),
> >>
> >>                TP_fast_assign(
> >> @@ -1124,7 +1124,7 @@
> >>                ),
> >>
> >>                TP_printk(
> >> -                       "error=%d (%s) inode=%02x:%02x:%llu",
> >> +                       "error=%lu (%s) inode=%02x:%02x:%llu",
> >>                        __entry->error,
> >>                        show_nfsv4_errors(__entry->error),
> >>                        MAJOR(__entry->dev), MINOR(__entry->dev),
> >> @@ -1145,7 +1145,7 @@
> >>
> >>                TP_STRUCT__entry(
> >>                        __field(dev_t, dev)
> >> -                       __field(int, error)
> >> +                       __field(unsigned long, error)
> >>                        __field(u64, olddir)
> >>                        __string(oldname, oldname->name)
> >>                        __field(u64, newdir)
> >> @@ -1162,7 +1162,7 @@
> >>                ),
> >>
> >>                TP_printk(
> >> -                       "error=%d (%s) oldname=%02x:%02x:%llu/%s "
> >> +                       "error=%lu (%s) oldname=%02x:%02x:%llu/%s "
> >>                        "newname=%02x:%02x:%llu/%s",
> >>                        __entry->error,
> >>                        show_nfsv4_errors(__entry->error),
> >> @@ -1187,18 +1187,18 @@
> >>                        __field(dev_t, dev)
> >>                        __field(u32, fhandle)
> >>                        __field(u64, fileid)
> >> -                       __field(int, error)
> >> +                       __field(unsigned long, error)
> >>                ),
> >>
> >>                TP_fast_assign(
> >>                        __entry->dev = inode->i_sb->s_dev;
> >>                        __entry->fileid = NFS_FILEID(inode);
> >>                        __entry->fhandle = nfs_fhandle_hash(NFS_FH(inode));
> >> -                       __entry->error = error;
> >> +                       __entry->error = error < 0 ? -error : 0;
> >>                ),
> >>
> >>                TP_printk(
> >> -                       "error=%d (%s) fileid=%02x:%02x:%llu fhandle=0x%08x",
> >> +                       "error=%lu (%s) fileid=%02x:%02x:%llu fhandle=0x%08x",
> >>                        __entry->error,
> >>                        show_nfsv4_errors(__entry->error),
> >>                        MAJOR(__entry->dev), MINOR(__entry->dev),
> >> @@ -1238,7 +1238,7 @@
> >>                        __field(dev_t, dev)
> >>                        __field(u32, fhandle)
> >>                        __field(u64, fileid)
> >> -                       __field(int, error)
> >> +                       __field(unsigned long, error)
> >>                        __field(int, stateid_seq)
> >>                        __field(u32, stateid_hash)
> >>                ),
> >> @@ -1255,7 +1255,7 @@
> >>                ),
> >>
> >>                TP_printk(
> >> -                       "error=%d (%s) fileid=%02x:%02x:%llu fhandle=0x%08x "
> >> +                       "error=%lu (%s) fileid=%02x:%02x:%llu fhandle=0x%08x "
> >>                        "stateid=%d:0x%08x",
> >>                        __entry->error,
> >>                        show_nfsv4_errors(__entry->error),
> >> @@ -1295,7 +1295,7 @@
> >>                        __field(u32, fhandle)
> >>                        __field(u64, fileid)
> >>                        __field(unsigned int, valid)
> >> -                       __field(int, error)
> >> +                       __field(unsigned long, error)
> >>                ),
> >>
> >>                TP_fast_assign(
> >> @@ -1307,7 +1307,7 @@
> >>                ),
> >>
> >>                TP_printk(
> >> -                       "error=%d (%s) fileid=%02x:%02x:%llu fhandle=0x%08x "
> >> +                       "error=%lu (%s) fileid=%02x:%02x:%llu fhandle=0x%08x "
> >>                        "valid=%s",
> >>                        __entry->error,
> >>                        show_nfsv4_errors(__entry->error),
> >> @@ -1342,7 +1342,7 @@
> >>                TP_ARGS(clp, fhandle, inode, error),
> >>
> >>                TP_STRUCT__entry(
> >> -                       __field(int, error)
> >> +                       __field(unsigned long, error)
> >>                        __field(dev_t, dev)
> >>                        __field(u32, fhandle)
> >>                        __field(u64, fileid)
> >> @@ -1363,7 +1363,7 @@
> >>                ),
> >>
> >>                TP_printk(
> >> -                       "error=%d (%s) fileid=%02x:%02x:%llu fhandle=0x%08x "
> >> +                       "error=%lu (%s) fileid=%02x:%02x:%llu fhandle=0x%08x "
> >>                        "dstaddr=%s",
> >>                        __entry->error,
> >>                        show_nfsv4_errors(__entry->error),
> >> @@ -1397,7 +1397,7 @@
> >>                TP_ARGS(clp, fhandle, inode, stateid, error),
> >>
> >>                TP_STRUCT__entry(
> >> -                       __field(int, error)
> >> +                       __field(unsigned long, error)
> >>                        __field(dev_t, dev)
> >>                        __field(u32, fhandle)
> >>                        __field(u64, fileid)
> >> @@ -1424,7 +1424,7 @@
> >>                ),
> >>
> >>                TP_printk(
> >> -                       "error=%d (%s) fileid=%02x:%02x:%llu fhandle=0x%08x "
> >> +                       "error=%lu (%s) fileid=%02x:%02x:%llu fhandle=0x%08x "
> >>                        "stateid=%d:0x%08x dstaddr=%s",
> >>                        __entry->error,
> >>                        show_nfsv4_errors(__entry->error),
> >> @@ -1460,7 +1460,7 @@
> >>                TP_ARGS(name, len, id, error),
> >>
> >>                TP_STRUCT__entry(
> >> -                       __field(int, error)
> >> +                       __field(unsigned long, error)
> >>                        __field(u32, id)
> >>                        __dynamic_array(char, name, len > 0 ? len + 1 : 1)
> >>                ),
> >> @@ -1475,8 +1475,8 @@
> >>                ),
> >>
> >>                TP_printk(
> >> -                       "error=%d id=%u name=%s",
> >> -                       __entry->error,
> >> +                       "error=%lu (%s) id=%u name=%s",
> >> +                       __entry->error, show_nfsv4_errors(__entry->error),
> >>                        __entry->id,
> >>                        __get_str(name)
> >>                )
> >> @@ -1509,7 +1509,7 @@
> >>                        __field(u64, fileid)
> >>                        __field(loff_t, offset)
> >>                        __field(size_t, count)
> >> -                       __field(int, error)
> >> +                       __field(unsigned long, error)
> >>                        __field(int, stateid_seq)
> >>                        __field(u32, stateid_hash)
> >>                ),
> >> @@ -1523,7 +1523,7 @@
> >>                        __entry->fhandle = nfs_fhandle_hash(NFS_FH(inode));
> >>                        __entry->offset = hdr->args.offset;
> >>                        __entry->count = hdr->args.count;
> >> -                       __entry->error = error;
> >> +                       __entry->error = error < 0 ? -error : 0;
> >>                        __entry->stateid_seq =
> >>                                be32_to_cpu(state->stateid.seqid);
> >>                        __entry->stateid_hash =
> >> @@ -1531,7 +1531,7 @@
> >>                ),
> >>
> >>                TP_printk(
> >> -                       "error=%d (%s) fileid=%02x:%02x:%llu fhandle=0x%08x "
> >> +                       "error=%lu (%s) fileid=%02x:%02x:%llu fhandle=0x%08x "
> >>                        "offset=%lld count=%zu stateid=%d:0x%08x",
> >>                        __entry->error,
> >>                        show_nfsv4_errors(__entry->error),
> >> @@ -1569,7 +1569,7 @@
> >>                        __field(u64, fileid)
> >>                        __field(loff_t, offset)
> >>                        __field(size_t, count)
> >> -                       __field(int, error)
> >> +                       __field(unsigned long, error)
> >>                        __field(int, stateid_seq)
> >>                        __field(u32, stateid_hash)
> >>                ),
> >> @@ -1583,7 +1583,7 @@
> >>                        __entry->fhandle = nfs_fhandle_hash(NFS_FH(inode));
> >>                        __entry->offset = hdr->args.offset;
> >>                        __entry->count = hdr->args.count;
> >> -                       __entry->error = error;
> >> +                       __entry->error = error < 0 ? -error : 0;
> >>                        __entry->stateid_seq =
> >>                                be32_to_cpu(state->stateid.seqid);
> >>                        __entry->stateid_hash =
> >> @@ -1591,7 +1591,7 @@
> >>                ),
> >>
> >>                TP_printk(
> >> -                       "error=%d (%s) fileid=%02x:%02x:%llu fhandle=0x%08x "
> >> +                       "error=%lu (%s) fileid=%02x:%02x:%llu fhandle=0x%08x "
> >>                        "offset=%lld count=%zu stateid=%d:0x%08x",
> >>                        __entry->error,
> >>                        show_nfsv4_errors(__entry->error),
> >> @@ -1630,7 +1630,7 @@
> >>                        __field(u64, fileid)
> >>                        __field(loff_t, offset)
> >>                        __field(size_t, count)
> >> -                       __field(int, error)
> >> +                       __field(unsigned long, error)
> >>                ),
> >>
> >>                TP_fast_assign(
> >> @@ -1644,7 +1644,7 @@
> >>                ),
> >>
> >>                TP_printk(
> >> -                       "error=%d (%s) fileid=%02x:%02x:%llu fhandle=0x%08x "
> >> +                       "error=%lu (%s) fileid=%02x:%02x:%llu fhandle=0x%08x "
> >>                        "offset=%lld count=%zu",
> >>                        __entry->error,
> >>                        show_nfsv4_errors(__entry->error),
> >> @@ -1694,7 +1694,7 @@
> >>                        __field(u32, iomode)
> >>                        __field(u64, offset)
> >>                        __field(u64, count)
> >> -                       __field(int, error)
> >> +                       __field(unsigned long, error)
> >>                        __field(int, stateid_seq)
> >>                        __field(u32, stateid_hash)
> >>                        __field(int, layoutstateid_seq)
> >> @@ -1727,7 +1727,7 @@
> >>                ),
> >>
> >>                TP_printk(
> >> -                       "error=%d (%s) fileid=%02x:%02x:%llu fhandle=0x%08x "
> >> +                       "error=%lu (%s) fileid=%02x:%02x:%llu fhandle=0x%08x "
> >>                        "iomode=%s offset=%llu count=%llu stateid=%d:0x%08x "
> >>                        "layoutstateid=%d:0x%08x",
> >>                        __entry->error,
>
> --
> Chuck Lever
>
>
>

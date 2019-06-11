Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75CA63D6EB
	for <lists+linux-nfs@lfdr.de>; Tue, 11 Jun 2019 21:37:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405261AbfFKThV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 11 Jun 2019 15:37:21 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:56770 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404788AbfFKThV (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 11 Jun 2019 15:37:21 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5BJZjlL155375;
        Tue, 11 Jun 2019 19:37:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=nP+Ibe78/ANBGjhT8Z0rzqkvIHocUUcMlZtROlI5xp8=;
 b=sAbzGo5PuLJJT0QNZ+5O/S5rSLTG2SRC1syq9YE8zFbHTJU7ugYYbgiqPAelrZBPGy7g
 XY9ChdQN1TL7yyKVugEnMAsSSIqkFlR65pnFpd+bUjQc3RzW9IOLuaxqxzPHZQyM6XbT
 f1YPJsOrFWnWYt/GGu4gy2rynJnaQ6S7fu9FVsPRsAbXZFwZV8QrRlRPKSEdtrCwuOoP
 0cslkcbP3NPhvElvTPHAW2CJTtr2grTRB30zqQHoMOkuQjA0PqypLQD2WXCZ6RT4O/yB
 pN5VChAmxbE9V3vqsvptkBBZbFVhOk4niUAa/LV1AFOgFNJ5gtsAUGwLtNh28/pa0JEF fA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2t05nqq7xc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jun 2019 19:37:13 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5BJa9VC131190;
        Tue, 11 Jun 2019 19:37:12 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 2t0p9rfrud-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jun 2019 19:37:12 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x5BJbBQJ022839;
        Tue, 11 Jun 2019 19:37:11 GMT
Received: from anon-dhcp-171.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 11 Jun 2019 12:37:10 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH v2 16/19] NFS: Fix show_nfs_errors macros again
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <CAN-5tyHx-r6c6RgHk2ocv2CxTgw_8Ebie_fUUSxzaVKotmX1zw@mail.gmail.com>
Date:   Tue, 11 Jun 2019 15:37:07 -0400
Cc:     linux-rdma <linux-rdma@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <C5542119-E526-4A69-9D15-B0EDEFF1E5A9@oracle.com>
References: <20190611150445.2877.8656.stgit@manet.1015granger.net>
 <20190611150923.2877.6862.stgit@manet.1015granger.net>
 <CAN-5tyHx-r6c6RgHk2ocv2CxTgw_8Ebie_fUUSxzaVKotmX1zw@mail.gmail.com>
To:     Olga Kornievskaia <aglo@umich.edu>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9284 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906110125
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9284 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906110125
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jun 11, 2019, at 3:33 PM, Olga Kornievskaia <aglo@umich.edu> wrote:
>=20
> On Tue, Jun 11, 2019 at 11:09 AM Chuck Lever <chuck.lever@oracle.com> =
wrote:
>>=20
>> I noticed that NFS status values stopped working again.
>>=20
>> trace_print_symbols_seq() takes an unsigned long. Passing a negative
>> errno or negative NFSERR value just confuses it, and since we're
>> using C macros here and not static inline functions, all bets are
>> off due to implicit type casting.
>>=20
>> Straight-line the calling conventions so that error codes are stored
>> in the trace record as positive values in an unsigned long field.
>>=20
>> It's often the case that an error value that is positive is a byte
>> count but when it's negative, it's an error (e.g. nfs4_write). Fix
>> those cases so that the value that is eventually stored in the
>> error field is a positive NFS status or errno, or zero.
>>=20
>=20
> Hi Chuck,
>=20
> To clarify, so on error case, we no longer going be seeing a negative
> value so error=3D-5 (EIO) would be error=3D5 (EIO)? I have always =
relied
> on searching for "error=3D-" thru the trace_pipe log for errors. Do we
> really need to change that?

error=3D will be zero or a positive errno/status code. If the trace =
point
has a count=3D or task->tk_status=3D you can see the byte count when
error=3D0.

So now the search will be for anything that has "error=3D" but is not
"error=3D0".


>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>> ---
>> fs/nfs/nfs4trace.h |  120 =
++++++++++++++++++++++++++--------------------------
>> 1 file changed, 60 insertions(+), 60 deletions(-)
>>=20
>> diff --git a/fs/nfs/nfs4trace.h b/fs/nfs/nfs4trace.h
>> index 6beb1f2..9a01731 100644
>> --- a/fs/nfs/nfs4trace.h
>> +++ b/fs/nfs/nfs4trace.h
>> @@ -156,7 +156,7 @@
>> TRACE_DEFINE_ENUM(NFS4ERR_XDEV);
>>=20
>> #define show_nfsv4_errors(error) \
>> -       __print_symbolic(-(error), \
>> +       __print_symbolic(error, \
>>                { NFS4_OK, "OK" }, \
>>                /* Mapped by nfs4_stat_to_errno() */ \
>>                { EPERM, "EPERM" }, \
>> @@ -348,7 +348,7 @@
>>=20
>>                TP_STRUCT__entry(
>>                        __string(dstaddr, clp->cl_hostname)
>> -                       __field(int, error)
>> +                       __field(unsigned long, error)
>>                ),
>>=20
>>                TP_fast_assign(
>> @@ -357,7 +357,7 @@
>>                ),
>>=20
>>                TP_printk(
>> -                       "error=3D%d (%s) dstaddr=3D%s",
>> +                       "error=3D%lu (%s) dstaddr=3D%s",
>>                        __entry->error,
>>                        show_nfsv4_errors(__entry->error),
>>                        __get_str(dstaddr)
>> @@ -420,7 +420,7 @@
>>                        __field(unsigned int, highest_slotid)
>>                        __field(unsigned int, target_highest_slotid)
>>                        __field(unsigned int, status_flags)
>> -                       __field(int, error)
>> +                       __field(unsigned long, error)
>>                ),
>>=20
>>                TP_fast_assign(
>> @@ -435,7 +435,7 @@
>>                        __entry->error =3D res->sr_status;
>>                ),
>>                TP_printk(
>> -                       "error=3D%d (%s) session=3D0x%08x slot_nr=3D%u =
seq_nr=3D%u "
>> +                       "error=3D%lu (%s) session=3D0x%08x slot_nr=3D%u=
 seq_nr=3D%u "
>>                        "highest_slotid=3D%u target_highest_slotid=3D%u =
"
>>                        "status_flags=3D%u (%s)",
>>                        __entry->error,
>> @@ -467,7 +467,7 @@
>>                        __field(unsigned int, seq_nr)
>>                        __field(unsigned int, highest_slotid)
>>                        __field(unsigned int, cachethis)
>> -                       __field(int, error)
>> +                       __field(unsigned long, error)
>>                ),
>>=20
>>                TP_fast_assign(
>> @@ -476,11 +476,11 @@
>>                        __entry->seq_nr =3D args->csa_sequenceid;
>>                        __entry->highest_slotid =3D =
args->csa_highestslotid;
>>                        __entry->cachethis =3D args->csa_cachethis;
>> -                       __entry->error =3D -be32_to_cpu(status);
>> +                       __entry->error =3D be32_to_cpu(status);
>>                ),
>>=20
>>                TP_printk(
>> -                       "error=3D%d (%s) session=3D0x%08x slot_nr=3D%u =
seq_nr=3D%u "
>> +                       "error=3D%lu (%s) session=3D0x%08x slot_nr=3D%u=
 seq_nr=3D%u "
>>                        "highest_slotid=3D%u",
>>                        __entry->error,
>>                        show_nfsv4_errors(__entry->error),
>> @@ -504,7 +504,7 @@
>>                        __field(unsigned int, seq_nr)
>>                        __field(unsigned int, highest_slotid)
>>                        __field(unsigned int, cachethis)
>> -                       __field(int, error)
>> +                       __field(unsigned long, error)
>>                ),
>>=20
>>                TP_fast_assign(
>> @@ -513,11 +513,11 @@
>>                        __entry->seq_nr =3D args->csa_sequenceid;
>>                        __entry->highest_slotid =3D =
args->csa_highestslotid;
>>                        __entry->cachethis =3D args->csa_cachethis;
>> -                       __entry->error =3D -be32_to_cpu(status);
>> +                       __entry->error =3D be32_to_cpu(status);
>>                ),
>>=20
>>                TP_printk(
>> -                       "error=3D%d (%s) session=3D0x%08x slot_nr=3D%u =
seq_nr=3D%u "
>> +                       "error=3D%lu (%s) session=3D0x%08x slot_nr=3D%u=
 seq_nr=3D%u "
>>                        "highest_slotid=3D%u",
>>                        __entry->error,
>>                        show_nfsv4_errors(__entry->error),
>> @@ -572,18 +572,18 @@
>>=20
>>                TP_STRUCT__entry(
>>                        __field(u32, op)
>> -                       __field(int, error)
>> +                       __field(unsigned long, error)
>>                ),
>>=20
>>                TP_fast_assign(
>>                        __entry->op =3D op;
>> -                       __entry->error =3D -error;
>> +                       __entry->error =3D error;
>>                ),
>>=20
>>                TP_printk(
>> -                       "operation %d: nfs status %d (%s)",
>> -                       __entry->op,
>> -                       __entry->error, =
show_nfsv4_errors(__entry->error)
>> +                       "error=3D%lu (%s) operation %d:",
>> +                       __entry->error, =
show_nfsv4_errors(__entry->error),
>> +                       __entry->op
>>                )
>> );
>>=20
>> @@ -597,7 +597,7 @@
>>                TP_ARGS(ctx, flags, error),
>>=20
>>                TP_STRUCT__entry(
>> -                       __field(int, error)
>> +                       __field(unsigned long, error)
>>                        __field(unsigned int, flags)
>>                        __field(unsigned int, fmode)
>>                        __field(dev_t, dev)
>> @@ -615,7 +615,7 @@
>>                        const struct nfs4_state *state =3D ctx->state;
>>                        const struct inode *inode =3D NULL;
>>=20
>> -                       __entry->error =3D error;
>> +                       __entry->error =3D -error;
>>                        __entry->flags =3D flags;
>>                        __entry->fmode =3D (__force unsigned =
int)ctx->mode;
>>                        __entry->dev =3D ctx->dentry->d_sb->s_dev;
>> @@ -647,7 +647,7 @@
>>                ),
>>=20
>>                TP_printk(
>> -                       "error=3D%d (%s) flags=3D%d (%s) fmode=3D%s "
>> +                       "error=3D%lu (%s) flags=3D%d (%s) fmode=3D%s =
"
>>                        "fileid=3D%02x:%02x:%llu fhandle=3D0x%08x "
>>                        "name=3D%02x:%02x:%llu/%s stateid=3D%d:0x%08x =
"
>>                        "openstateid=3D%d:0x%08x",
>> @@ -733,7 +733,7 @@
>>                        __field(u32, fhandle)
>>                        __field(u64, fileid)
>>                        __field(unsigned int, fmode)
>> -                       __field(int, error)
>> +                       __field(unsigned long, error)
>>                        __field(int, stateid_seq)
>>                        __field(u32, stateid_hash)
>>                ),
>> @@ -753,7 +753,7 @@
>>                ),
>>=20
>>                TP_printk(
>> -                       "error=3D%d (%s) fmode=3D%s =
fileid=3D%02x:%02x:%llu "
>> +                       "error=3D%lu (%s) fmode=3D%s =
fileid=3D%02x:%02x:%llu "
>>                        "fhandle=3D0x%08x openstateid=3D%d:0x%08x",
>>                        __entry->error,
>>                        show_nfsv4_errors(__entry->error),
>> @@ -795,7 +795,7 @@
>>                TP_ARGS(request, state, cmd, error),
>>=20
>>                TP_STRUCT__entry(
>> -                       __field(int, error)
>> +                       __field(unsigned long, error)
>>                        __field(int, cmd)
>>                        __field(char, type)
>>                        __field(loff_t, start)
>> @@ -825,7 +825,7 @@
>>                ),
>>=20
>>                TP_printk(
>> -                       "error=3D%d (%s) cmd=3D%s:%s range=3D%lld:%lld =
"
>> +                       "error=3D%lu (%s) cmd=3D%s:%s range=3D%lld:%lld=
 "
>>                        "fileid=3D%02x:%02x:%llu fhandle=3D0x%08x "
>>                        "stateid=3D%d:0x%08x",
>>                        __entry->error,
>> @@ -865,7 +865,7 @@
>>                TP_ARGS(request, state, lockstateid, cmd, error),
>>=20
>>                TP_STRUCT__entry(
>> -                       __field(int, error)
>> +                       __field(unsigned long, error)
>>                        __field(int, cmd)
>>                        __field(char, type)
>>                        __field(loff_t, start)
>> @@ -901,7 +901,7 @@
>>                ),
>>=20
>>                TP_printk(
>> -                       "error=3D%d (%s) cmd=3D%s:%s range=3D%lld:%lld =
"
>> +                       "error=3D%lu (%s) cmd=3D%s:%s range=3D%lld:%lld=
 "
>>                        "fileid=3D%02x:%02x:%llu fhandle=3D0x%08x "
>>                        "stateid=3D%d:0x%08x lockstateid=3D%d:0x%08x",
>>                        __entry->error,
>> @@ -970,7 +970,7 @@
>>                TP_STRUCT__entry(
>>                        __field(dev_t, dev)
>>                        __field(u32, fhandle)
>> -                       __field(int, error)
>> +                       __field(unsigned long, error)
>>                        __field(int, stateid_seq)
>>                        __field(u32, stateid_hash)
>>                ),
>> @@ -986,7 +986,7 @@
>>                ),
>>=20
>>                TP_printk(
>> -                       "error=3D%d (%s) dev=3D%02x:%02x =
fhandle=3D0x%08x "
>> +                       "error=3D%lu (%s) dev=3D%02x:%02x =
fhandle=3D0x%08x "
>>                        "stateid=3D%d:0x%08x",
>>                        __entry->error,
>>                        show_nfsv4_errors(__entry->error),
>> @@ -1007,7 +1007,7 @@
>>                TP_ARGS(state, lsp, error),
>>=20
>>                TP_STRUCT__entry(
>> -                       __field(int, error)
>> +                       __field(unsigned long, error)
>>                        __field(dev_t, dev)
>>                        __field(u32, fhandle)
>>                        __field(u64, fileid)
>> @@ -1029,7 +1029,7 @@
>>                ),
>>=20
>>                TP_printk(
>> -                       "error=3D%d (%s) fileid=3D%02x:%02x:%llu =
fhandle=3D0x%08x "
>> +                       "error=3D%lu (%s) fileid=3D%02x:%02x:%llu =
fhandle=3D0x%08x "
>>                        "stateid=3D%d:0x%08x",
>>                        __entry->error,
>>                        show_nfsv4_errors(__entry->error),
>> @@ -1064,7 +1064,7 @@
>>=20
>>                TP_STRUCT__entry(
>>                        __field(dev_t, dev)
>> -                       __field(int, error)
>> +                       __field(unsigned long, error)
>>                        __field(u64, dir)
>>                        __string(name, name->name)
>>                ),
>> @@ -1072,12 +1072,12 @@
>>                TP_fast_assign(
>>                        __entry->dev =3D dir->i_sb->s_dev;
>>                        __entry->dir =3D NFS_FILEID(dir);
>> -                       __entry->error =3D error;
>> +                       __entry->error =3D -error;
>>                        __assign_str(name, name->name);
>>                ),
>>=20
>>                TP_printk(
>> -                       "error=3D%d (%s) name=3D%02x:%02x:%llu/%s",
>> +                       "error=3D%lu (%s) name=3D%02x:%02x:%llu/%s",
>>                        __entry->error,
>>                        show_nfsv4_errors(__entry->error),
>>                        MAJOR(__entry->dev), MINOR(__entry->dev),
>> @@ -1114,7 +1114,7 @@
>>                TP_STRUCT__entry(
>>                        __field(dev_t, dev)
>>                        __field(u64, ino)
>> -                       __field(int, error)
>> +                       __field(unsigned long, error)
>>                ),
>>=20
>>                TP_fast_assign(
>> @@ -1124,7 +1124,7 @@
>>                ),
>>=20
>>                TP_printk(
>> -                       "error=3D%d (%s) inode=3D%02x:%02x:%llu",
>> +                       "error=3D%lu (%s) inode=3D%02x:%02x:%llu",
>>                        __entry->error,
>>                        show_nfsv4_errors(__entry->error),
>>                        MAJOR(__entry->dev), MINOR(__entry->dev),
>> @@ -1145,7 +1145,7 @@
>>=20
>>                TP_STRUCT__entry(
>>                        __field(dev_t, dev)
>> -                       __field(int, error)
>> +                       __field(unsigned long, error)
>>                        __field(u64, olddir)
>>                        __string(oldname, oldname->name)
>>                        __field(u64, newdir)
>> @@ -1162,7 +1162,7 @@
>>                ),
>>=20
>>                TP_printk(
>> -                       "error=3D%d (%s) oldname=3D%02x:%02x:%llu/%s =
"
>> +                       "error=3D%lu (%s) oldname=3D%02x:%02x:%llu/%s =
"
>>                        "newname=3D%02x:%02x:%llu/%s",
>>                        __entry->error,
>>                        show_nfsv4_errors(__entry->error),
>> @@ -1187,18 +1187,18 @@
>>                        __field(dev_t, dev)
>>                        __field(u32, fhandle)
>>                        __field(u64, fileid)
>> -                       __field(int, error)
>> +                       __field(unsigned long, error)
>>                ),
>>=20
>>                TP_fast_assign(
>>                        __entry->dev =3D inode->i_sb->s_dev;
>>                        __entry->fileid =3D NFS_FILEID(inode);
>>                        __entry->fhandle =3D =
nfs_fhandle_hash(NFS_FH(inode));
>> -                       __entry->error =3D error;
>> +                       __entry->error =3D error < 0 ? -error : 0;
>>                ),
>>=20
>>                TP_printk(
>> -                       "error=3D%d (%s) fileid=3D%02x:%02x:%llu =
fhandle=3D0x%08x",
>> +                       "error=3D%lu (%s) fileid=3D%02x:%02x:%llu =
fhandle=3D0x%08x",
>>                        __entry->error,
>>                        show_nfsv4_errors(__entry->error),
>>                        MAJOR(__entry->dev), MINOR(__entry->dev),
>> @@ -1238,7 +1238,7 @@
>>                        __field(dev_t, dev)
>>                        __field(u32, fhandle)
>>                        __field(u64, fileid)
>> -                       __field(int, error)
>> +                       __field(unsigned long, error)
>>                        __field(int, stateid_seq)
>>                        __field(u32, stateid_hash)
>>                ),
>> @@ -1255,7 +1255,7 @@
>>                ),
>>=20
>>                TP_printk(
>> -                       "error=3D%d (%s) fileid=3D%02x:%02x:%llu =
fhandle=3D0x%08x "
>> +                       "error=3D%lu (%s) fileid=3D%02x:%02x:%llu =
fhandle=3D0x%08x "
>>                        "stateid=3D%d:0x%08x",
>>                        __entry->error,
>>                        show_nfsv4_errors(__entry->error),
>> @@ -1295,7 +1295,7 @@
>>                        __field(u32, fhandle)
>>                        __field(u64, fileid)
>>                        __field(unsigned int, valid)
>> -                       __field(int, error)
>> +                       __field(unsigned long, error)
>>                ),
>>=20
>>                TP_fast_assign(
>> @@ -1307,7 +1307,7 @@
>>                ),
>>=20
>>                TP_printk(
>> -                       "error=3D%d (%s) fileid=3D%02x:%02x:%llu =
fhandle=3D0x%08x "
>> +                       "error=3D%lu (%s) fileid=3D%02x:%02x:%llu =
fhandle=3D0x%08x "
>>                        "valid=3D%s",
>>                        __entry->error,
>>                        show_nfsv4_errors(__entry->error),
>> @@ -1342,7 +1342,7 @@
>>                TP_ARGS(clp, fhandle, inode, error),
>>=20
>>                TP_STRUCT__entry(
>> -                       __field(int, error)
>> +                       __field(unsigned long, error)
>>                        __field(dev_t, dev)
>>                        __field(u32, fhandle)
>>                        __field(u64, fileid)
>> @@ -1363,7 +1363,7 @@
>>                ),
>>=20
>>                TP_printk(
>> -                       "error=3D%d (%s) fileid=3D%02x:%02x:%llu =
fhandle=3D0x%08x "
>> +                       "error=3D%lu (%s) fileid=3D%02x:%02x:%llu =
fhandle=3D0x%08x "
>>                        "dstaddr=3D%s",
>>                        __entry->error,
>>                        show_nfsv4_errors(__entry->error),
>> @@ -1397,7 +1397,7 @@
>>                TP_ARGS(clp, fhandle, inode, stateid, error),
>>=20
>>                TP_STRUCT__entry(
>> -                       __field(int, error)
>> +                       __field(unsigned long, error)
>>                        __field(dev_t, dev)
>>                        __field(u32, fhandle)
>>                        __field(u64, fileid)
>> @@ -1424,7 +1424,7 @@
>>                ),
>>=20
>>                TP_printk(
>> -                       "error=3D%d (%s) fileid=3D%02x:%02x:%llu =
fhandle=3D0x%08x "
>> +                       "error=3D%lu (%s) fileid=3D%02x:%02x:%llu =
fhandle=3D0x%08x "
>>                        "stateid=3D%d:0x%08x dstaddr=3D%s",
>>                        __entry->error,
>>                        show_nfsv4_errors(__entry->error),
>> @@ -1460,7 +1460,7 @@
>>                TP_ARGS(name, len, id, error),
>>=20
>>                TP_STRUCT__entry(
>> -                       __field(int, error)
>> +                       __field(unsigned long, error)
>>                        __field(u32, id)
>>                        __dynamic_array(char, name, len > 0 ? len + 1 =
: 1)
>>                ),
>> @@ -1475,8 +1475,8 @@
>>                ),
>>=20
>>                TP_printk(
>> -                       "error=3D%d id=3D%u name=3D%s",
>> -                       __entry->error,
>> +                       "error=3D%lu (%s) id=3D%u name=3D%s",
>> +                       __entry->error, =
show_nfsv4_errors(__entry->error),
>>                        __entry->id,
>>                        __get_str(name)
>>                )
>> @@ -1509,7 +1509,7 @@
>>                        __field(u64, fileid)
>>                        __field(loff_t, offset)
>>                        __field(size_t, count)
>> -                       __field(int, error)
>> +                       __field(unsigned long, error)
>>                        __field(int, stateid_seq)
>>                        __field(u32, stateid_hash)
>>                ),
>> @@ -1523,7 +1523,7 @@
>>                        __entry->fhandle =3D =
nfs_fhandle_hash(NFS_FH(inode));
>>                        __entry->offset =3D hdr->args.offset;
>>                        __entry->count =3D hdr->args.count;
>> -                       __entry->error =3D error;
>> +                       __entry->error =3D error < 0 ? -error : 0;
>>                        __entry->stateid_seq =3D
>>                                be32_to_cpu(state->stateid.seqid);
>>                        __entry->stateid_hash =3D
>> @@ -1531,7 +1531,7 @@
>>                ),
>>=20
>>                TP_printk(
>> -                       "error=3D%d (%s) fileid=3D%02x:%02x:%llu =
fhandle=3D0x%08x "
>> +                       "error=3D%lu (%s) fileid=3D%02x:%02x:%llu =
fhandle=3D0x%08x "
>>                        "offset=3D%lld count=3D%zu stateid=3D%d:0x%08x",=

>>                        __entry->error,
>>                        show_nfsv4_errors(__entry->error),
>> @@ -1569,7 +1569,7 @@
>>                        __field(u64, fileid)
>>                        __field(loff_t, offset)
>>                        __field(size_t, count)
>> -                       __field(int, error)
>> +                       __field(unsigned long, error)
>>                        __field(int, stateid_seq)
>>                        __field(u32, stateid_hash)
>>                ),
>> @@ -1583,7 +1583,7 @@
>>                        __entry->fhandle =3D =
nfs_fhandle_hash(NFS_FH(inode));
>>                        __entry->offset =3D hdr->args.offset;
>>                        __entry->count =3D hdr->args.count;
>> -                       __entry->error =3D error;
>> +                       __entry->error =3D error < 0 ? -error : 0;
>>                        __entry->stateid_seq =3D
>>                                be32_to_cpu(state->stateid.seqid);
>>                        __entry->stateid_hash =3D
>> @@ -1591,7 +1591,7 @@
>>                ),
>>=20
>>                TP_printk(
>> -                       "error=3D%d (%s) fileid=3D%02x:%02x:%llu =
fhandle=3D0x%08x "
>> +                       "error=3D%lu (%s) fileid=3D%02x:%02x:%llu =
fhandle=3D0x%08x "
>>                        "offset=3D%lld count=3D%zu stateid=3D%d:0x%08x",=

>>                        __entry->error,
>>                        show_nfsv4_errors(__entry->error),
>> @@ -1630,7 +1630,7 @@
>>                        __field(u64, fileid)
>>                        __field(loff_t, offset)
>>                        __field(size_t, count)
>> -                       __field(int, error)
>> +                       __field(unsigned long, error)
>>                ),
>>=20
>>                TP_fast_assign(
>> @@ -1644,7 +1644,7 @@
>>                ),
>>=20
>>                TP_printk(
>> -                       "error=3D%d (%s) fileid=3D%02x:%02x:%llu =
fhandle=3D0x%08x "
>> +                       "error=3D%lu (%s) fileid=3D%02x:%02x:%llu =
fhandle=3D0x%08x "
>>                        "offset=3D%lld count=3D%zu",
>>                        __entry->error,
>>                        show_nfsv4_errors(__entry->error),
>> @@ -1694,7 +1694,7 @@
>>                        __field(u32, iomode)
>>                        __field(u64, offset)
>>                        __field(u64, count)
>> -                       __field(int, error)
>> +                       __field(unsigned long, error)
>>                        __field(int, stateid_seq)
>>                        __field(u32, stateid_hash)
>>                        __field(int, layoutstateid_seq)
>> @@ -1727,7 +1727,7 @@
>>                ),
>>=20
>>                TP_printk(
>> -                       "error=3D%d (%s) fileid=3D%02x:%02x:%llu =
fhandle=3D0x%08x "
>> +                       "error=3D%lu (%s) fileid=3D%02x:%02x:%llu =
fhandle=3D0x%08x "
>>                        "iomode=3D%s offset=3D%llu count=3D%llu =
stateid=3D%d:0x%08x "
>>                        "layoutstateid=3D%d:0x%08x",
>>                        __entry->error,

--
Chuck Lever




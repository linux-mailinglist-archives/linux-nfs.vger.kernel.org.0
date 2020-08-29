Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECF8E256AA1
	for <lists+linux-nfs@lfdr.de>; Sun, 30 Aug 2020 00:29:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728007AbgH2W2V (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 29 Aug 2020 18:28:21 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:32884 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727987AbgH2W2U (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 29 Aug 2020 18:28:20 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07TMKV4E061952;
        Sat, 29 Aug 2020 22:28:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=KePSAVVj3jXLfWM+Nwjv4Uo3mAjNKCVsZ3at6+YyVuQ=;
 b=PVPuhtYQEh4p2rYJp6W2AGfzA8K8cBgQIki7uyF2zvHcF5Xh+eLL4O1lSqDE4hr7SWLk
 NIIspCiU1NbQlkl3V2NX8xROIs0TJzbghaijmfEH9tzkKfbYb1UFrbmiHIj3fKAd05EU
 tJNOD7dzt+YTpTDYWM/rRoJPhHFSd2lrqATOWme9ZCBMur8XTbQB1kAiao4EtYXohuQB
 ViriISRNeE5q5IlqJZCHki891rqM3TFCusw7Rri7/0kDq5sUHzjvWruHMwaoPGY1Lo0c
 GDCYFwOMMK2PFAP8R+b2AhULSbjCMGgqQwZwTCZLI+4FtABAoPVEv6tk5IilUT9k7PWZ LA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 337eykskng-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 29 Aug 2020 22:28:13 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07TMRJ6A068058;
        Sat, 29 Aug 2020 22:28:13 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 337d29m87r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 29 Aug 2020 22:28:13 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 07TMSAbA030821;
        Sat, 29 Aug 2020 22:28:12 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 29 Aug 2020 15:28:10 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.1\))
Subject: Re: [PATCH v2] NFS: Zero-stateid SETATTR should first return
 delegation
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <9e28664e90438384be654a39b23c6d517959c15a.camel@hammerspace.com>
Date:   Sat, 29 Aug 2020 18:28:09 -0400
Cc:     Anna Schumaker <anna.schumaker@netapp.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <84BE6361-2381-442D-9788-74ABB54C88A7@oracle.com>
References: <159872131590.1096729.3952588635826859724.stgit@manet.1015granger.net>
 <9e28664e90438384be654a39b23c6d517959c15a.camel@hammerspace.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
X-Mailer: Apple Mail (2.3608.120.23.2.1)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9728 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 bulkscore=0
 spamscore=0 mlxlogscore=999 phishscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008290183
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9728 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 priorityscore=1501 phishscore=0 mlxlogscore=999 mlxscore=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 bulkscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008290182
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Aug 29, 2020, at 5:17 PM, Trond Myklebust <trondmy@hammerspace.com> =
wrote:
>=20
> On Sat, 2020-08-29 at 13:16 -0400, Chuck Lever wrote:
>> If a write delegation isn't available, the Linux NFS client uses
>> a zero-stateid when performing a SETATTR.
>>=20
>> NFSv4.0 provides no mechanism for an NFS server to match such a
>> request to a particular client. It recalls all delegations for that
>> file, even delegations held by the client issuing the request. If
>> that client happens to hold a read delegation, the server will
>> recall it immediately, resulting in an NFS4ERR_DELAY/CB_RECALL/
>> DELEGRETURN sequence.
>>=20
>> Optimize out this pipeline bubble by having the client return any
>> delegations it may hold on a file before it issues a
>> SETATTR(zero-stateid) on that file.
>>=20
>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>> ---
>> fs/nfs/nfs4proc.c |    2 ++
>> 1 file changed, 2 insertions(+)
>>=20
>> Changes since v1:
>> - Return the delegation only for NFSv4.0 mounts
>>=20
>> diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
>> index dbd01548335b..bca7245f1e78 100644
>> --- a/fs/nfs/nfs4proc.c
>> +++ b/fs/nfs/nfs4proc.c
>> @@ -3314,6 +3314,8 @@ static int _nfs4_do_setattr(struct inode
>> *inode,
>> 			goto zero_stateid;
>> 	} else {
>> zero_stateid:
>> +		if (server->nfs_client->cl_minorversion =3D=3D 0)
>> +			nfs4_inode_return_delegation(inode);
>=20
> So, the intention is that nfs4_inode_make_writeable() takes care of
> this, and in principle it is done in the cases that matter in
> nfs4_proc_setattr().

Thanks for pointing out the nfs4_inode_make_writeable call site!

 4219         /* Return any delegations if we're going to change ACLs */
 4220         if ((sattr->ia_valid & (ATTR_MODE|ATTR_UID|ATTR_GID)) !=3D =
0)
 4221                 nfs4_inode_make_writeable(inode);


> I agree that the zero_stateid case is not currently being taken care
> of, but that only matters for the case of truncate. So perhaps we can
> just add a single call to nfs4_inode_make_writeable() above the
> zero_stateid label instead of adding redundancy for all the other
> cases?

I'm willing to consider other solutions, but something else is going
on here. I've added some instrumentation to nfsd_setattr. It shows
that the iattr mask does not have the SIZE bit set:

nfsd_compound:        xid=3D0x8ffc7b48 opcnt=3D3
nfsd_compound_status: op=3D1/3 OP_PUTFH status=3D0

nfsd_setattr:         xid=3D0x8ffc7b48 fh_hash=3D0x2aed0c4d =
valid=3DATIME|MTIME|ATIME_SET|MTIME_SET

time_out_leases:      fl=3D0xffff8887006c7ea0 dev=3D0x0:0x23 =
ino=3D0x16d825 fl_blocker=3D(nil) fl_owner=3D0xffff88872928e000 =
fl_flags=3DFL_DELEG fl_type=3DF_RDLCK fl_break_time=3D0 fl_downgrade
_time=3D0
leases_conflict:      conflict 1: lease=3D0xffff8887006c7ea0 =
fl_flags=3DFL_DELEG fl_type=3DF_RDLCK; breaker=3D0xffff8887006c6e38 =
fl_flags=3DFL_DELEG fl_type=3DF_WRLCK
leases_conflict:      conflict 1: lease=3D0xffff8887006c7ea0 =
fl_flags=3DFL_DELEG fl_type=3DF_RDLCK; breaker=3D0xffff8887006c6e38 =
fl_flags=3DFL_DELEG fl_type=3DF_WRLCK
nfsd_deleg_break:     client 5f4a926c:cd5044d5 stateid 00063dd9:00000001
break_lease_noblock:  fl=3D0xffff8887006c6e38 dev=3D0x0:0x23 =
ino=3D0x16d825 fl_blocker=3D(nil) fl_owner=3D(nil) fl_flags=3DFL_DELEG =
fl_type=3DF_WRLCK fl_break_time=3D0 fl_downgrade_time=3D0
nfsd_cb_work:         addr=3D192.168.2.51:35037 client 5f4a926c:cd5044d5 =
procedure=3DCB_RECALL
nfsd_compound_status: op=3D2/3 OP_SETATTR status=3D10008



--
Chuck Lever




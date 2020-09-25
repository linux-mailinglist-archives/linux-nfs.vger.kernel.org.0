Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BB67278AC9
	for <lists+linux-nfs@lfdr.de>; Fri, 25 Sep 2020 16:21:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728431AbgIYOVo (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 25 Sep 2020 10:21:44 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:55264 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728330AbgIYOVn (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 25 Sep 2020 10:21:43 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08PEK764176098;
        Fri, 25 Sep 2020 14:21:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=3pBg6xmFHl6U8TzExtd88wPf1/vbNloXOsLLOtZMhro=;
 b=Tk+b8Xr6rmXovwW7LWcnpgvq6ID9gi8LYXKeFO0JGUNK2ASz43nCqDHQTjHC7g2qfuP5
 mfK/CMZfwJlhZsHQXoEHCrn1+Fh9KOA502sUJhBYof9z8a7YIf5a1sFQEcaogj/faO99
 qSdwJQDR2S84uWJvnHq2BE3VmylNLmbetH9MkbLHPY/MYHI5Cl3O/M//8dk4Gv3Detm7
 xSTjWBgnjG7iPj3Q/qFO5vk3GC5QRP8CRJWiNXej1JRy04+HLv6Yd/yWrSSxqVg1xah5
 frrwgfBtDhjxbb9M3XIxz+uVpwd/mBVpJIc9eB0fMpx5d5Ui2yiR5EGCmnPESyOjXQHO 3w== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 33qcpuaw4f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 25 Sep 2020 14:21:42 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08PEKaV0164315;
        Fri, 25 Sep 2020 14:21:42 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 33nurxv7vw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Sep 2020 14:21:42 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 08PELflX028074;
        Fri, 25 Sep 2020 14:21:41 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 25 Sep 2020 07:21:40 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.1\))
Subject: Re: [PATCH v2 26/27] NFSD: Add tracepoints in the NFS dispatcher
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20200925141716.GC1096@fieldses.org>
Date:   Fri, 25 Sep 2020 10:21:40 -0400
Cc:     Bill Baker <Bill.Baker@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <39D76A18-F134-4A3C-9B50-FEE46564E945@oracle.com>
References: <160071167664.1468.1365570508917640511.stgit@klimt.1015granger.net>
 <160071198717.1468.14262284967190973528.stgit@klimt.1015granger.net>
 <20200924234526.GB12407@fieldses.org>
 <801F3A94-4668-4DF6-9CAF-27171EEBA17A@oracle.com>
 <20200925141716.GC1096@fieldses.org>
To:     Bruce Fields <bfields@fieldses.org>
X-Mailer: Apple Mail (2.3608.120.23.2.1)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9755 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 phishscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009250102
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9755 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 adultscore=0 bulkscore=0 mlxscore=0 lowpriorityscore=0 priorityscore=1501
 phishscore=0 spamscore=0 malwarescore=0 clxscore=1015 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009250102
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Sep 25, 2020, at 10:17 AM, Bruce Fields <bfields@fieldses.org> =
wrote:
>=20
> On Fri, Sep 25, 2020 at 09:59:54AM -0400, Chuck Lever wrote:
>>=20
>>=20
>>> On Sep 24, 2020, at 7:45 PM, J. Bruce Fields <bfields@fieldses.org> =
wrote:
>>>=20
>>> On Mon, Sep 21, 2020 at 02:13:07PM -0400, Chuck Lever wrote:
>>>> This is follow-on work to the tracepoints added in the NFS server's
>>>> duplicate reply cache. Here, tracepoints are introduced that report
>>>> replies from cache as well as encoding and decoding errors.
>>>>=20
>>>> The NFSv2, v3, and v4 dispatcher requirements have diverged over
>>>> time, leaving us with a little bit of technical debt. In addition,
>>>> I wanted to add a tracepoint for NFSv2 and NFSv3 similar to the
>>>> nfsd4_compound/compoundstatus tracepoints. Lastly, removing some
>>>> conditional branches from this hot path helps optimize CPU
>>>> utilization. So, I've duplicated the nfsd_dispatcher function.
>>>=20
>>> Comparing current nfsd_dispatch to the nfsv2/v3 nfsd_dispatch: the =
only
>>> thing I spotted removed from the v2/v3-specific dispatch is the
>>> rq_lease_breaker =3D NULL.  (I think that's not correct, actually.  =
We
>>> could remove the need for that to be set in the v2/v3 case, but with =
the
>>> current code it does need to be set.)
>>=20
>> Noted with thanks.
>=20
> Maybe just do this?

I'll try it out. Thanks!


> --b.
>=20
> commit c7265a111269
> Author: J. Bruce Fields <bfields@redhat.com>
> Date:   Fri Sep 25 10:12:39 2020 -0400
>=20
>    nfsd: rq_lease_breaker cleanup
>=20
>    Since only the v4 code cares about it, maybe it's better to leave
>    rq_lease_breaker out of the common dispatch code?
>=20
>    Signed-off-by: J. Bruce Fields <bfields@redhat.com>
>=20
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 62afcae18e17..a498278ba96b 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -4597,6 +4597,9 @@ static bool nfsd_breaker_owns_lease(struct =
file_lock *fl)
>=20
> 	if (!i_am_nfsd())
> 		return NULL;
> +	/* Note rq_prog =3D=3D NFS_ACL_PROGRAM is also possible: */
> +	if (rqst->rq_prog !=3D NFS_PROGRAM || rqst->rq_vers < 4)
> +		return NULL;
> 	rqst =3D kthread_data(current);
> 	clp =3D *(rqst->rq_lease_breaker);
> 	return dl->dl_stid.sc_client =3D=3D clp;
> diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
> index b603dfcdd361..8d6f6f4c8b28 100644
> --- a/fs/nfsd/nfssvc.c
> +++ b/fs/nfsd/nfssvc.c
> @@ -1016,7 +1016,6 @@ nfsd_dispatch(struct svc_rqst *rqstp, __be32 =
*statp)
> 		*statp =3D rpc_garbage_args;
> 		return 1;
> 	}
> -	rqstp->rq_lease_breaker =3D NULL;
> 	/*
> 	 * Give the xdr decoder a chance to change this if it wants
> 	 * (necessary in the NFSv4.0 compound case)

--
Chuck Lever




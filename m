Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53B324839A8
	for <lists+linux-nfs@lfdr.de>; Tue,  4 Jan 2022 02:12:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbiADBMp (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 3 Jan 2022 20:12:45 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:31178 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229853AbiADBMo (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 3 Jan 2022 20:12:44 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 203K1PVj029678;
        Tue, 4 Jan 2022 01:12:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=fuIQPs4yJTl4TAKBarAZgNp/eaPg/hBMPVBkcby+PwA=;
 b=MW3226jqbsSi9CyBWAEoUxwd4m8VQsUsK0o03wfHTgUkPUWsMh1po3i1c+xI4BaCFz0E
 1S6eYSFjhlKTWgd8UjCyXtSL7iKbqhY+C0Tdz9rZSWrKDl789lp22qN4RoZEwlfSO45s
 UOSG7LrFB9VHWhgOGHIRP5aZQ3cyKtRFvlohKIOgp6b2ezhS0u9ikBido8QiuN6PFd3l
 3395vk1wz32smFeK7eqqsyrMSEtgsidvcu5ZumoCPX/Wb1X+XhGgBV0+HT7gauI0qraD
 kF9/+MhE6GKBJO3467jHvsHU0jzVmbrGPvPRiOF7gW1C4MN2T0yBjuQ4oGvTTZoUCr1w Ww== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dc3st12dd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 04 Jan 2022 01:12:42 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2041C26U152471;
        Tue, 4 Jan 2022 01:12:42 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
        by aserp3030.oracle.com with ESMTP id 3dad0cu3ub-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 04 Jan 2022 01:12:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jhaG0SzANuX5F4mo+dPI986FJBSGezopUJC4ExMqvxfAM5rS685X1wlHSVONtZZjkt0qzvRTwdYPf+j65ObldOAgvZQZ7ifEGP8O+LvPcolIpavTBopmj8yhk5GhFh8aFjWEwN/2vxYQeGOyuzmIKI/rw9xeR95hhbd3YN1hpiD3Vc2z0e5jJ7ScZ8nPO6RpDhvEPAWTK4Deg45y7bC3rR2rwYXhkKOr/H2ARpPJS890gXalgL3oc4z31ay5Q6e1g1YcmzMF/Sp/My7IL8iFi888od4Ct35wNVzCfBnS3dZ9xVhclV8sKDU3Txrop/whzw9ybkoamZ1ujBTuDCrUUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fuIQPs4yJTl4TAKBarAZgNp/eaPg/hBMPVBkcby+PwA=;
 b=ZyymGPxby6ErPQ8dsJoY6dQpOVQnBmF+UNtOEawD8Dt3WT6FKMm7ndg5i99VDkQ94Xvy3JASzwa1FOB03ncmF3ANxsahpsmt+hjbX7CLJczAK1ZXPh4Lh7keweSBzvzNNz2/e1Hz9VS7FX13G2OKGpe7hBOdC7eIt5DoHmeYc72ixYUswFnojo+s/aCcB9g7CrCTWEvnsH+lwacjrWTwD2Sh3+/xezaSZ/AFa2hlb4p9G5fi8iXQ0n6zJTFlK/wqUcFegIqCqsjwEt9ErTspP5g0nwh5UQ7QSDyDdCmrawHaZq6oAVJtDiLHtWmhFSv0gtpdis5k7lU+JNj0dbvZXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fuIQPs4yJTl4TAKBarAZgNp/eaPg/hBMPVBkcby+PwA=;
 b=fcNsr/hSLqBIjFvc0KNkOdgb6FYfVWIARG3PM+xn0bbztN3sGo13qzNIcflofOlSdXPr5FTu60SNrt7Gu94WqfhGLQFDvHbk11iInZQFXoQGsDuiKnn3le1f9akeQHv/JMqlztOjjQKHRkYSIjRpkN4fxGswIUdTamvVStWH2uY=
Received: from CH0PR10MB4858.namprd10.prod.outlook.com (2603:10b6:610:cb::17)
 by CH2PR10MB4374.namprd10.prod.outlook.com (2603:10b6:610:af::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.15; Tue, 4 Jan
 2022 01:12:40 +0000
Received: from CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::241e:15fa:e7d8:dea7]) by CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::241e:15fa:e7d8:dea7%9]) with mapi id 15.20.4844.016; Tue, 4 Jan 2022
 01:12:40 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Bruce Fields <bfields@fieldses.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH RFC] NFSD: Fix zero-length NFSv3 WRITEs
Thread-Topic: [PATCH RFC] NFSD: Fix zero-length NFSv3 WRITEs
Thread-Index: AQHX9n63ywgIG6CFSEaOkZMalnKYnaxR3M+AgABGiIA=
Date:   Tue, 4 Jan 2022 01:12:40 +0000
Message-ID: <BAA88CD4-C692-4AEE-9A8D-F62F8CBEA2F5@oracle.com>
References: <164010014140.6448.18108343631467243001.stgit@klimt.1015granger.net>
 <20220103210013.GK21514@fieldses.org>
In-Reply-To: <20220103210013.GK21514@fieldses.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b2b551f4-c06e-44dd-ab6f-08d9cf1f4d98
x-ms-traffictypediagnostic: CH2PR10MB4374:EE_
x-microsoft-antispam-prvs: <CH2PR10MB43742BA538CCF4A2B5A70701934A9@CH2PR10MB4374.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: t8s0jsvTGYDvc7GeYAirGvMVI8w3C4EH06jmhBtAzf9clwLsCIMg1s32tfk24V7+5FWCerEuQRsqBUfT97Nbb0Kz9rZ3+UDIVn7uuvBYEkbw3LaDRRFuLOab4jom5N3k3ntQpSy/7wCmGJBPCwEuuWFvx2s5qWQokytSPLCqQdDazcpSL+p8PChdj5pMud5KXc9jwzE4DOz+RsxNGNpTPyDNeXJPintdvS8vkyAa3hrV2/ZtTWEbHMBbgam20DUgIXPxCu0VYRZYu2gsQQ2hyaYQjc7kXnTWS/PSeemKIWypobpRBQ1Wyurn4lxfrO8X/mjMSapQUzPjjtjVu3DKuKgRlfht//Ab5LrJe8b3i4P3NhcaLGC82vXkweTyVpdV7eJAsyhvWsJ9WL2ti1qB9BoZWNNCz16Bv043kCxP8DeDqE2li6/goIEkPu/oIg673Y2a9ld/dSxMorwjjRep0mS+VW6vMkm49RTI7LcJ6DIAi/i1DCkeJkStiye6Y50H4qfs1+5MtauYttaqFjQPFr+qcwiBzOXk1uPrlQTqBJyK+sKAD2c+OBQnMpA+Z24GrUw45g7QEypdlVfjrgD77pepJFzvzQZ8UmViBG1Q4AkX96MMr3xv+d8YCCZsHK9+nIc8rH+FPdH82jbfQqVnZS3vNL3XloJno6s+AdI+3quj7aIFH1MKK51ovMMfEbE0gHjuXFDbvOFEkNpFMY1D6U6FiZoMmbyX2YGx8nmHQmz17KcT73RsTO5EiMOomP6P
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB4858.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(76116006)(36756003)(5660300002)(2616005)(6506007)(38100700002)(6916009)(53546011)(66556008)(33656002)(8676002)(64756008)(6512007)(2906002)(4326008)(66476007)(8936002)(66946007)(6486002)(86362001)(316002)(66446008)(508600001)(122000001)(38070700005)(71200400001)(83380400001)(186003)(26005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?QihCpxnYLs644i0Nsnd6uRHuxIpFwSfMsZphQGMHfCdffuvDVyeBvagFYzQg?=
 =?us-ascii?Q?BCWxD8N00JO5h71hMcXFS8YSLkFLyymDY6wz4CzHpfZND4I93p6Nz7ipEVF3?=
 =?us-ascii?Q?25Sq/D1gm9GMb6LhKl3VzR+88kBSXQBXJIi9+xtfX2g1aDWufmFuHns+xgkZ?=
 =?us-ascii?Q?vlc2/KLe3fpIf9K3qU53txmS3w70iAONu/7PrlHnzmyK215SyFRjX48ZiHNe?=
 =?us-ascii?Q?q596VkkUiFietlKhU++uF+C53oswhZSSRAvWoIPV1QvgSZJKiaUsCvXFEiuw?=
 =?us-ascii?Q?WGW9/lziGZ83d6aOy9koA0FuD7wFafR3sENP0vGEkqe0Guzme3g0tpQnAHME?=
 =?us-ascii?Q?xYH9TphdUSq2G5EChuG+f4s8VFabaI+LgXW7I1lauG1E/tzPjoCsweb4OCTS?=
 =?us-ascii?Q?6KANriZQOsuxVVpbakj440mqfMeD1Fhr4JlgG9HRUIYcETbWuyqD+dYejktm?=
 =?us-ascii?Q?89imhR2FQ8nnlpH2L58f/c6jcZpJ+Pq1ef9DPCgeAys6S0wUygjQyWsEdffW?=
 =?us-ascii?Q?tv7tFzVPprYAZReh/Wtz6m99GXXXtPh0t9AHmpnPAfrQeUI23/wJcC14xBDt?=
 =?us-ascii?Q?+HlIeikVIfSLlrtwku+oyT4b/CO20H+FsPPzupabH2JPjrKBTu5wiGQl1Odz?=
 =?us-ascii?Q?oFH6aQnT4DxZC8eU536cjrI5LCPtNZU39sPwKY/Lq0vUri7whHpz+6FxOQPD?=
 =?us-ascii?Q?iPAjoymFYuwKoscGzBuIPf+MqYnbdQ/wLnniO55EiFVMvfrFa7TBOSVPw+jr?=
 =?us-ascii?Q?oRK+A69bRrEwS4uo/O+HT04/J4FyFmJgV6qUIwIca4zXWdEw2E4aTPQ/g6mA?=
 =?us-ascii?Q?Ejo+rMbiOdl0GADqJgS8AjcUny7X/MRKny6sIb6UDmBQzmQm0x2/nJzB0uMC?=
 =?us-ascii?Q?2sFUjiDqbJgtLDUmA4IG5udBfe/DdaJIyIfbK818KoWwnAsmi23sz8puRKuv?=
 =?us-ascii?Q?SP7OxmxtfCEkU5C6LFmrgU9vYm7OK18uBDfgRZbn5HtH77JutnKpnizcxyGP?=
 =?us-ascii?Q?xpvWGfYpf5xtVufs8Wx6qzXauaXBNQwVsQXbcSFJGLxraVh5VelooaRjjqYo?=
 =?us-ascii?Q?bkvLh7RcOHI4b70n2v4TexR+cquxXWNRCFtk4WXccQd61pQ5VPsDKKFpl1dh?=
 =?us-ascii?Q?8FvYfy0TvZjLmfoLcCONvlqAo0aVlQcqHJPqzzN12z62cClPVFPwDjzZIiWs?=
 =?us-ascii?Q?or8e53tQDvXrVmntRjzNGMaDUeu4wJ70nIRI4GNClyzApwINMF9MdNPbAuDA?=
 =?us-ascii?Q?fF7V0DzG8COCGGTziBXOHgSHDpszdjH7+zV/yWLu5lltV58XEtY/jNH713mP?=
 =?us-ascii?Q?ffnR6b5P75JKSQnxbcwTDIFeiiAfTo9pVNpg3Ju4GKuDX8YeKvZp6PtDxqoE?=
 =?us-ascii?Q?okFIaSJe4CbWjXpWvUK4nu6nooXrs+UNKFWxPVIh6/hN1auiMTNblKthk8Jn?=
 =?us-ascii?Q?WaJMo2y+clJH1YYUMOr4n4NKaefeFSw6rywCZ3gBNNsdNPv+VsCznpaxHTKu?=
 =?us-ascii?Q?/nkt7QVhbap4jUgOGB6w3a+37D91qgmimYKuBGdzrN7rnhkshD7Zr3yAkqBZ?=
 =?us-ascii?Q?WLb5xUe2whiWNDf/r9PPFn/sD0fVwVN6HOa91QfOwU93SJtZpkAeZpNgxswN?=
 =?us-ascii?Q?IEQOoe16CuCJt1qFUVB4fcs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <DB77BEF1487DB74BB7A476CABAAB8993@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB4858.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2b551f4-c06e-44dd-ab6f-08d9cf1f4d98
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jan 2022 01:12:40.1484
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tgrKWpT8TchUYPKv1euVXDNFBNWhLIJp5IPFypMjQvyfwMD6YjWbsFxXsDwMqd0y0pvfN6f9/aGL+frxjUaapQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4374
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10216 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 adultscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201040006
X-Proofpoint-GUID: wGDQQrG1IcjvslZq1VDTKWz2pYGnlzyW
X-Proofpoint-ORIG-GUID: wGDQQrG1IcjvslZq1VDTKWz2pYGnlzyW
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jan 3, 2022, at 4:00 PM, J. Bruce Fields <bfields@fieldses.org> wrote:
>=20
> On Tue, Dec 21, 2021 at 10:23:25AM -0500, Chuck Lever wrote:
>> The Linux NFS server currently responds to a zero-length NFSv3 WRITE
>> request with NFS3ERR_IO. It responds to a zero-length NFSv4 WRITE
>> with NFS4_OK and count of zero.
>>=20
>> RFC 1813 says of the WRITE procedure's @count argument:
>>=20
>> count
>>         The number of bytes of data to be written. If count is
>>         0, the WRITE will succeed and return a count of 0,
>>         barring errors due to permissions checking.
>>=20
>> RFC 8881 has similar language for NFSv4, though NFSv4 removed the
>> explicit @count argument because that value is already contained in
>> the opaque payload array.
>>=20
>> The synthetic client pynfs's WRT4 and WRT15 tests do emit zero-
>> length WRITEs to exercise this spec requirement, but interestingly
>> the Linux NFS client does not appear to emit zero-length WRITEs,
>> instead squelching them.
>>=20
>> I'm not aware of a test that can generate such WRITEs for NFSv3, so
>> I wrote a naive C program to generate a zero-length WRITE and test
>> this fix.
>=20
> I know it's probably only a few lines,

It is the same kind of code that Dr. Morris has posted recently.
I've saved it (somewhere). However...


> but still may be worth posting
> somewhere and making it the start of a collection of protocol-level v3
> tests.

... I question whether it's worth posting anything until there
is a framework for collecting and maintaining such things. I
do agree that the community should be working up a set of NFSv3
specific tests like this. I like Frank's idea of making them a
part of pynfs, fwiw.


> --b.
>=20
>>=20
>> Fixes: 14168d678a0f ("NFSD: Remove the RETURN_STATUS() macro")
>> Reported-by: Trond Myklebust <trond.myklebust@hammerspace.com>
>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>> ---
>>=20
>> Here's an alternate approach to addressing the zero-length NFSv3
>> WRITE failures.
>>=20
>>=20
>> fs/nfsd/nfs3proc.c |    6 +-----
>> fs/nfsd/nfsproc.c  |    5 -----
>> 2 files changed, 1 insertion(+), 10 deletions(-)
>>=20
>> diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
>> index 4418517f6f12..2c681785186f 100644
>> --- a/fs/nfsd/nfs3proc.c
>> +++ b/fs/nfsd/nfs3proc.c
>> @@ -202,15 +202,11 @@ nfsd3_proc_write(struct svc_rqst *rqstp)
>> 	fh_copy(&resp->fh, &argp->fh);
>> 	resp->committed =3D argp->stable;
>> 	nvecs =3D svc_fill_write_vector(rqstp, &argp->payload);
>> -	if (!nvecs) {
>> -		resp->status =3D nfserr_io;
>> -		goto out;
>> -	}
>> +
>> 	resp->status =3D nfsd_write(rqstp, &resp->fh, argp->offset,
>> 				  rqstp->rq_vec, nvecs, &cnt,
>> 				  resp->committed, resp->verf);
>> 	resp->count =3D cnt;
>> -out:
>> 	return rpc_success;
>> }
>>=20
>> diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
>> index eea5b59b6a6c..1743ed04197e 100644
>> --- a/fs/nfsd/nfsproc.c
>> +++ b/fs/nfsd/nfsproc.c
>> @@ -235,10 +235,6 @@ nfsd_proc_write(struct svc_rqst *rqstp)
>> 		argp->len, argp->offset);
>>=20
>> 	nvecs =3D svc_fill_write_vector(rqstp, &argp->payload);
>> -	if (!nvecs) {
>> -		resp->status =3D nfserr_io;
>> -		goto out;
>> -	}
>>=20
>> 	resp->status =3D nfsd_write(rqstp, fh_copy(&resp->fh, &argp->fh),
>> 				  argp->offset, rqstp->rq_vec, nvecs,
>> @@ -247,7 +243,6 @@ nfsd_proc_write(struct svc_rqst *rqstp)
>> 		resp->status =3D fh_getattr(&resp->fh, &resp->stat);
>> 	else if (resp->status =3D=3D nfserr_jukebox)
>> 		return rpc_drop_reply;
>> -out:
>> 	return rpc_success;
>> }

--
Chuck Lever




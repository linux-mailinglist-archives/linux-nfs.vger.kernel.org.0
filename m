Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF0BA3B07EF
	for <lists+linux-nfs@lfdr.de>; Tue, 22 Jun 2021 16:52:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231849AbhFVOyW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 22 Jun 2021 10:54:22 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:52090 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230304AbhFVOyS (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 22 Jun 2021 10:54:18 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15MEpAMb032601;
        Tue, 22 Jun 2021 14:52:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=oCbtkf1hk19uM1/eVtPWTB1OPUGyMrtVyfE57o29hjM=;
 b=w35MsEml3Sc8ctHmG0tQ784dZM+ZMw/ikS/toMkVxtqnCW277zV5L+EiMd5RNFWwGusl
 o/y/stJryHcMWxL//+Ly2dYbDsVtLV21c9CIO2dukVp5rmpgq74/vvEYSlpwCXNFCHNp
 UvCbRw8WH+FugPJ1Anfg97WzZshISHAO9/rKowb0V0iRK9nRcaMshkDpk1gvnPPAi7PZ
 pyEfWvfkOzRPGDpzEjFvBGigKr265Sb08P93RX9g74p95Ys15t0C1XnDkWcRqzAI+B/U
 pa2mRHOlOhMOVs/B+dzKDnRIAAXQ1q5MATXw6P4YPRw8voRhZs97hAwpQ7/SG1bXevIz CA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 39anpuunyk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Jun 2021 14:51:59 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15MEpqh0189743;
        Tue, 22 Jun 2021 14:51:58 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2104.outbound.protection.outlook.com [104.47.55.104])
        by userp3020.oracle.com with ESMTP id 399tbsvb0q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Jun 2021 14:51:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M07FMrR9gEB4JdNDCYA49Raa8CeJa861gF3CMuVoRTaMee1kjbVol4MXDEBUc+W2fWxaKGFmP0IAXOZtyrT5oZbBPCFGGGHhtowLeqesfhISvxyfknMCanA9+QheUJICnsO2vEA/d+lDDIcjETdkoq937aN+Bc2qW4EuUYXnQW2iaQJFFDs/L5nSHZnM5SMnnICEmo6qReFC6YxSHBlVZwiU3Y7lqhKZSg6SmeTStfbgIU5hjSkRvoeJby4z6BV645Fnk4HH4KcQP0tpK0iQ4/OXrVP3qxsi2zM1EPHlPk+IUaiGcSuz1bpLWEjwnHWUZtTeM9zXWSCKeQuNrJsCHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oCbtkf1hk19uM1/eVtPWTB1OPUGyMrtVyfE57o29hjM=;
 b=I3yzT4sstCx/qMX59cirPwf0gci4b5hBS+eOpdQWkukjNvfFzEUojiNNDNGYSzhvJ7Fly6BG0Y3M9R5fXZQmNfgysGzvrYqsyofPH++SG3Hf6fgnCmUFVqyrmjhSOPsNxaculp283dOiOiqCuW6EVyPBLxzH7jLBSVd5DeCOJgWC5kmEgbzwPDQ/aXLMgvbqd5zRSOvhUU97AgyN2wiE1c2CLmgvBGvTmSKxog+pMN9a6C2Hctyw25qGdVxIsQPgA+qjJw63AfgAoDjiQNlsyilENHOuIG1qN5N2g+c2uB8FNagxnTw0Rm4a9Fgw+UAWY5stuhlV65JfkVW/hW3f0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oCbtkf1hk19uM1/eVtPWTB1OPUGyMrtVyfE57o29hjM=;
 b=vzaMyv8h8B+6DkFWew4QmVuUB6lAtFkdd43NrlhLmi5Nw5W1s5naTV7V/ojzAJQnmFuGMTId9NJ0IDCboGT3vIQvTN2jJ6T44H9VL5bLVrZCfOWDBnz+xrUZepzRM7q3gi1IkC6J9cjlJ1H7uF9T2hMYc2jn0qtq/MbfzSPkc8s=
Received: from CO1PR10MB4673.namprd10.prod.outlook.com (2603:10b6:303:91::8)
 by CO1PR10MB4756.namprd10.prod.outlook.com (2603:10b6:303:9b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18; Tue, 22 Jun
 2021 14:51:52 +0000
Received: from CO1PR10MB4673.namprd10.prod.outlook.com
 ([fe80::b8c9:68e1:7d35:a288]) by CO1PR10MB4673.namprd10.prod.outlook.com
 ([fe80::b8c9:68e1:7d35:a288%6]) with mapi id 15.20.4264.018; Tue, 22 Jun 2021
 14:51:52 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     "trondmy@kernel.org" <trondmy@kernel.org>,
        Bruce Fields <bfields@redhat.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] nfsd: Reduce contention for the nfsd_file nf_rwsem
Thread-Topic: [PATCH] nfsd: Reduce contention for the nfsd_file nf_rwsem
Thread-Index: AQHXY9BFZBFmWOpSekG1W92QMIYbjKsgJKSA
Date:   Tue, 22 Jun 2021 14:51:52 +0000
Message-ID: <F61924B3-3FC0-4FEF-BEFB-9802D9A852B7@oracle.com>
References: <20210617232652.264884-1-trondmy@kernel.org>
In-Reply-To: <20210617232652.264884-1-trondmy@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d727c1d6-7b56-483f-f3cd-08d9358d45eb
x-ms-traffictypediagnostic: CO1PR10MB4756:
x-microsoft-antispam-prvs: <CO1PR10MB4756404A68BABA822719C6F793099@CO1PR10MB4756.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:595;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: k7DmSN7V7ZDtmzt3aKLR0yH1IbTvySdkOwBh+oNKE3t/a4xFzNvp97vT6AGAcSniRR2gpPWZSxhiimX9k0MtyU+sXOIc6DmXqws4D8nwhupLtLJHy1YiGkvt3RdSjuCZ7HgeTUBP/BQZJzVuxqXQL9JMfdJXJC109iRg/eJmIkPYBC7MfolFsVlhw2WlhDhL/u0QvnAq2La+dx5K1XVL4uouoB5GFiQ9TVKt8uHdObCJWmrHohxit0+8lFXQxMIFBv5UZJWPxeMzr+IuhpAx8lWS/oT88flQujeYXOELFStJ4LVHqVSXhTWKofyaEQIMiJncKaQshsLv1F2m4fvOvqDwbLwy0+sIdWz+aiatC0zAgKpjDZbs4rIAmAnQYJr+30osL0PG8oXJIAimPSXS4C0LqPivsZfaMDhbKDoEeVXUH2DzQudm2XchERuH/gDT/rlOYRAZNYCV0ticvp8vScD0nGfPQ1BswpAWgargTSvl3hjV8b9lwI2dm+7M+3mCQ6DgWHVDbz50G9nu8Ntf/NPke8oq/tQqHkSR2IZtxzJozXwzMEfyd9VWO7d3EhRdv5q3dilgniAEI8XWQqurnAIw4tfeRepef+qwe6gxtPg2eOVU3tl5uQDXj5596PrziJjQ5FHY7pZqviswsHI6mlxNaiIljNDh84ZrbAprPUum7qdQmOzzdTOGQuJ6CHgglqHdvdq8A/II0LK7mMqJyQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4673.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66476007)(66556008)(64756008)(66446008)(83380400001)(91956017)(76116006)(186003)(66946007)(6512007)(6506007)(53546011)(26005)(498600001)(6486002)(36756003)(110136005)(71200400001)(2616005)(4326008)(33656002)(8676002)(86362001)(122000001)(38100700002)(8936002)(2906002)(5660300002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4xqWXyxqnJN1sqVvc2RyRnkp52shpKW+Yv36vUHk1edZjN6jD+30E7kYhft5?=
 =?us-ascii?Q?CEmHcTNun9Sz7trif9JZMXrFAdamz9GIP8KKiQq1K+Bld9rMksicWKn40H6+?=
 =?us-ascii?Q?7RO+yKq8ff6DdFzVRwNZ+mRM8xZnpXxa38L16lD2ov2q9ir59EKh8sIjfkKq?=
 =?us-ascii?Q?VD6DBq5yS1CnmWldjZCcm+6Ihapti1Cpm9XS/T7IYJLiq5/jqmsP6v+6yxmv?=
 =?us-ascii?Q?bN1Kp1Q0fvnAwvHvJ9gX86uHGuvCV8AtCywz1O6NKK2n+3fM/jRiXZVbc6pu?=
 =?us-ascii?Q?Eh4jMtbyWqNbTbBOeKTMkPskayjcPLUPuCcyZWBekdTtMzK+oygk9Hu8/Dj2?=
 =?us-ascii?Q?58n8xXhow3SJ18KnIR4fUQF18hShNcga96PhTp8gpgWwvof0cWrOhbq3io5m?=
 =?us-ascii?Q?xVw8vH2uLs+G3UIB3DRR63bOrr78E3K1SkXX5pWirl0Kv1C//TXTVNfw0tgZ?=
 =?us-ascii?Q?WMSlFRscKEdykOvDTaWfV6jGtkv4h+0vIJTHxFvgfDIRIGGUknjkDpi6s5SF?=
 =?us-ascii?Q?6h9FGLorTrGYrnZ8FSOMWfxCY9rdx15xUH8C74vuru8pAEZPz4YXsHD4z6Fw?=
 =?us-ascii?Q?TcCnF6MfhH9Wy4UWvz3laMxgT2aEhRfuDt27JffeBv1PCuIG7s8oeYsUS0jl?=
 =?us-ascii?Q?csjrY/UEQb2Z0w4uA3UaHZjVVDQ4bwFRJFNC+ru7qIxsSCKYKSSL/CHhu448?=
 =?us-ascii?Q?Y05J0zpjgNsxDS68etyCZfo0bB/eTapL1P7ea54y9IKoJWqOuDOiBXWlHt08?=
 =?us-ascii?Q?7RtAfNH8KmopCwkDynOMaLpU2HNIkh0EYyXVW//2s9Jo5+auW6wxfjuoXRX8?=
 =?us-ascii?Q?19NHLTyvdnuMe/gzBT1a99ePYP4YBOo9xoJDL8YaUuA9pT1ofuvlUixxACDc?=
 =?us-ascii?Q?zjGtQ3oGpBAmMib3/c/YH+nLh8G0LxQ7GfEZzwbIluub891UUvI5GfYP1Vj4?=
 =?us-ascii?Q?P7nIWJAaPXz7AuEUtfiPfheSURLC4s+PfU3l30Mfwjc4O/QoC5ngQxeyVx4Y?=
 =?us-ascii?Q?Ljvoz0lkkyMkIN0kGr3Y1hq1IMNUU0FiILlppKnRS+UdlsQYkJp4F3lMU/U+?=
 =?us-ascii?Q?n/8BcqfEfVwVFTSDW49Q7sTsKDg4HeH4UoFq8N98uCc2iKl5nwMdRkT/w1zL?=
 =?us-ascii?Q?di/C9RhXiOw2qlKt6yffwB+D3vR7U6frAJ0BoXMrquwqd2aYgTb7oBp5ouLB?=
 =?us-ascii?Q?IfPOFXtUdqvHBs9Ud4SvNsY1NfpbIx86fBUu7co52zxaLdkFA9rIDqeED5ft?=
 =?us-ascii?Q?o6fs+1qoCuBbSfNsUWP/QxHkPhK+/my3q8QN/tb2uqcjaHmATX/yTtIPVdWT?=
 =?us-ascii?Q?wklAmjQkJDt99YSHDWkEjmASFhoOFz1bWSWZC2MscTTFyA=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <48086B6293AFEB4BACF1BC69D77713F4@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4673.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d727c1d6-7b56-483f-f3cd-08d9358d45eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2021 14:51:52.8023
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vQfMeKTMTZX+SMyYW+q8IOOm2rkcuIhvLPCNWNpiafJ0kyklI67s33dk3Pn+eLFqHMJnhwlEtkQaOjP6zEOCSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4756
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10023 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 mlxscore=0
 spamscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106220092
X-Proofpoint-GUID: rCd2mPUSj50dLl8VZvh2zliyEXQ6Wots
X-Proofpoint-ORIG-GUID: rCd2mPUSj50dLl8VZvh2zliyEXQ6Wots
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


> On Jun 17, 2021, at 7:26 PM, trondmy@kernel.org wrote:
>=20
> From: Trond Myklebust <trond.myklebust@hammerspace.com>
>=20
> When flushing out the unstable file writes as part of a COMMIT call, try
> to perform most of of the data writes and waits outside the semaphore.
>=20
> This means that if the client is sending the COMMIT as part of a memory
> reclaim operation, then it can continue performing I/O, with contention
> for the lock occurring only once the data sync is finished.
>=20
> Fixes: 5011af4c698a ("nfsd: Fix stable writes")
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>

I can see write throughput improvement now.

Tested-by: Chuck Lever <chuck.lever@oracle.com>


This is NFSv3 against an NVMe-backed XFS export, wsize=3D8192:

v5.13-rc6:

	Command line used: /home/cel/bin/iozone -M -+u -i0 -i1 -s1g -r256k -t12 -I
	Output is in kBytes/sec
	Time Resolution =3D 0.000001 seconds.
	Processor cache size set to 1024 kBytes.
	Processor cache line size set to 32 bytes.
	File stride size set to 17 * record size.
	Throughput test with 12 processes
	Each process writes a 1048576 kByte file in 256 kByte records

	Children see throughput for 12 initial writers 	=3D  416004.59 kB/sec
	Parent sees throughput for 12 initial writers 	=3D  415691.65 kB/sec
	Min throughput per process 			=3D   34630.36 kB/sec=20
	Max throughput per process 			=3D   34703.62 kB/sec
	Avg throughput per process 			=3D   34667.05 kB/sec
	Min xfer 					=3D 1046528.00 kB
	CPU Utilization: Wall time   30.239    CPU time    5.854    CPU utilizatio=
n  19.36 %


	Children see throughput for 12 rewriters 	=3D  516605.59 kB/sec
	Parent sees throughput for 12 rewriters 	=3D  516530.05 kB/sec
	Min throughput per process 			=3D   43007.56 kB/sec=20
	Max throughput per process 			=3D   43074.50 kB/sec
	Avg throughput per process 			=3D   43050.47 kB/sec
	Min xfer 					=3D 1047040.00 kB
	CPU utilization: Wall time   24.347    CPU time    5.882    CPU utilizatio=
n  24.16 %

v5.13-rc6 + Trond's patch:

	Command line used: /home/cel/bin/iozone -M -+u -i0 -i1 -s1g -r256k -t12 -I
	Output is in kBytes/sec
	Time Resolution =3D 0.000001 seconds.
	Processor cache size set to 1024 kBytes.
	Processor cache line size set to 32 bytes.
	File stride size set to 17 * record size.
	Throughput test with 12 processes
	Each process writes a 1048576 kByte file in 256 kByte records

	Children see throughput for 12 initial writers 	=3D  434971.09 kB/sec
	Parent sees throughput for 12 initial writers 	=3D  434649.13 kB/sec
	Min throughput per process 			=3D   36209.41 kB/sec=20
	Max throughput per process 			=3D   36287.55 kB/sec
	Avg throughput per process 			=3D   36247.59 kB/sec
	Min xfer 					=3D 1046528.00 kB
	CPU Utilization: Wall time   28.920    CPU time    5.705    CPU utilizatio=
n  19.73 %


	Children see throughput for 12 rewriters 	=3D  544700.37 kB/sec
	Parent sees throughput for 12 rewriters 	=3D  544623.91 kB/sec
	Min throughput per process 			=3D   45320.82 kB/sec=20
	Max throughput per process 			=3D   45456.07 kB/sec
	Avg throughput per process 			=3D   45391.70 kB/sec
	Min xfer 					=3D 1045504.00 kB
	CPU utilization: Wall time   23.071    CPU time    5.708    CPU utilizatio=
n  24.74 %


> ---
> fs/nfsd/vfs.c | 18 ++++++++++++++++--
> 1 file changed, 16 insertions(+), 2 deletions(-)
>=20
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index 15adf1f6ab21..46485c04740d 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -1123,6 +1123,19 @@ nfsd_write(struct svc_rqst *rqstp, struct svc_fh *=
fhp, loff_t offset,
> }
>=20
> #ifdef CONFIG_NFSD_V3
> +static int
> +nfsd_filemap_write_and_wait_range(struct nfsd_file *nf, loff_t offset,
> +				  loff_t end)
> +{
> +	struct address_space *mapping =3D nf->nf_file->f_mapping;
> +	int ret =3D filemap_fdatawrite_range(mapping, offset, end);
> +
> +	if (ret)
> +		return ret;
> +	filemap_fdatawait_range_keep_errors(mapping, offset, end);
> +	return 0;
> +}
> +
> /*
>  * Commit all pending writes to stable storage.
>  *
> @@ -1153,10 +1166,11 @@ nfsd_commit(struct svc_rqst *rqstp, struct svc_fh=
 *fhp,
> 	if (err)
> 		goto out;
> 	if (EX_ISSYNC(fhp->fh_export)) {
> -		int err2;
> +		int err2 =3D nfsd_filemap_write_and_wait_range(nf, offset, end);
>=20
> 		down_write(&nf->nf_rwsem);
> -		err2 =3D vfs_fsync_range(nf->nf_file, offset, end, 0);
> +		if (!err2)
> +			err2 =3D vfs_fsync_range(nf->nf_file, offset, end, 0);
> 		switch (err2) {
> 		case 0:
> 			nfsd_copy_boot_verifier(verf, net_generic(nf->nf_net,
> --=20
> 2.31.1
>=20

--
Chuck Lever




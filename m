Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF07E5AC00D
	for <lists+linux-nfs@lfdr.de>; Sat,  3 Sep 2022 19:36:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbiICRgd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 3 Sep 2022 13:36:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231247AbiICRgc (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 3 Sep 2022 13:36:32 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7229045998
        for <linux-nfs@vger.kernel.org>; Sat,  3 Sep 2022 10:36:31 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2839Cawb017758;
        Sat, 3 Sep 2022 17:36:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=UafQpYBCuyA7ZRsFVD4mOhaA1atSKYjg7fsdgpjPy5M=;
 b=OWU24uRG6du6eiTg0qkBidixVmsQOxbYQo86jK/ryfVKuwgi9liWLyNU+d/toJk+0S2E
 urTkWnDQMB/vqIRkIw/YoOTL0UKTfkg4VC5UiQzsmWCvG/4byfDB4eYJ0jFRxInXNMwj
 UM15Nhc1L/VqXy9g4bQWIXYcgRqzMrTRsGZQpynXhvkZDVkX0CeQjW0RTP9fNTqzvvKt
 sZFSQS+tFJafqIi54L1xtt/N/qoZmTJJIUEAp6mVmEfvmQnpAXnmnNoLmgH20zl1MCga
 DOKi69Tumc0LHaR7/798Ootednv7By1w68yJsZICgmO4MagX1X/k/UnaFfu++ltkD/KC Vw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jbwq28vts-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 03 Sep 2022 17:36:26 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 283HKYit002767;
        Sat, 3 Sep 2022 17:36:26 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3jbwc0bby5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 03 Sep 2022 17:36:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WC/0tKeLm1ieH+cuqAOL671wtaE9vqMkmDBNl4lqBrozmDe59ZDERKc1KV0wVlqSkTCOUL5Z3GJd+YhH6aadkCanA2DSCdr51GC9knao8Rr3x+mxwUWO1kfv8Y7ajqNY4khf/L1SHD3Z8EtBSgYAa9/uMRW1ztgC+VrOkUFw11neD3nF80Mh5+kWlaX0GoElbjdr8gzmQ+kQ1oAaf3CQy/zP6xPtlcCMa+BjLHV9xwHVjMwF+/7TFFjMqclQHOWj7BL9wh0O5EW+IbXqUx1I3+WpK9yDVYICFtGeo6vAk2NF0pwvXEjE6Vn0Sw28iIGup0rusfSKH02mIdje9JCoqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UafQpYBCuyA7ZRsFVD4mOhaA1atSKYjg7fsdgpjPy5M=;
 b=hfw9yWgHEMqDnS3DJhssY3OBiY9hFKJbZ+sEcXJi6kZl3pByuAaMJedmJZTnBbcq9Lnl8jpDtlpNjynD+vyn2G/L0igYjRLkubUlT2aUamJbE0z8ahClit9x6RGJaPyPToDRXgQxBRHOQomHbj99m+E3R7BXXpZJe1wDcwmV+2D4rveziTQ4nmfuTPyXtUwuo2eJ2eosJ1oI5Y/yP5x7mSzW1DWukn3haNQWvD6lNw26kMt89EFDcWiyADgtgLspACGpzHVusXMBmBt4/giFrQXDK0KeG9qOPoZ2WrKlbaPgPqlPEVXNFA0+u/jRnrYnLsVp51tfxAwfLtN7ghE4yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UafQpYBCuyA7ZRsFVD4mOhaA1atSKYjg7fsdgpjPy5M=;
 b=K6UNQUWYSl5zIscHhiOxOAqXiN6rtZKGmIqnUOJt5LclK1p9ZAtRKI1vLbTgyC+mgwRO/02IAM+NjQIpqLy4rCZ6JJIonNgPzvQIYCN6T17l8ZXzpXH2CrTin17VOIdMRSTNUGHYuPfr5FRJDZSXwNRLS6pi448GXJypgGO2f4U=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BLAPR10MB4881.namprd10.prod.outlook.com (2603:10b6:208:327::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.12; Sat, 3 Sep
 2022 17:36:24 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::25d6:da15:34d:92fa]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::25d6:da15:34d:92fa%4]) with mapi id 15.20.5588.017; Sat, 3 Sep 2022
 17:36:24 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Anna Schumaker <anna@kernel.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 0/1] NFSD: Simplify READ_PLUS
Thread-Topic: [PATCH 0/1] NFSD: Simplify READ_PLUS
Thread-Index: AQHYvjFgBg77Wrnv30+1UKhkeKONIa3N+vyA
Date:   Sat, 3 Sep 2022 17:36:24 +0000
Message-ID: <0125F316-1D9C-4A0E-B1B9-1919C9F26718@oracle.com>
References: <20220901183341.1543827-1-anna@kernel.org>
In-Reply-To: <20220901183341.1543827-1-anna@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3cb3e04c-ae05-4161-8fb3-08da8dd2d299
x-ms-traffictypediagnostic: BLAPR10MB4881:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jaMESaaJVvbMUOKFOIbH0lvEWpJ2++QME69bUnypgYahxUmSt/ioB1jp01+spmVjWVjtks6qHiA0RYdA1pPzxsMbw9j2eYRouJWSAACWlFdBFCgI8OK4au3evxp7GoPJv56w+NWz///OqIyZZ0r+17cUFX9cB6n8N8d5eQIyewzPbVGGF9bS1j6RkNP7Tf0P0U/5lG+L4DJ3Asue5FwgzvRBhNXl7QPDV+6nQf7f9VljJpLEsXXqJx63xoEmHjYzJ/Br1eE8p4Gd7SpyWKjDkmI72QMvHxeeddnxfvrJtd3Z0eOrVrtkXWlroS6xoW4joDQ3/SIzr55cNhoRcy1mgCs1tJWNaL2cXQ0kfGLyn/Kso/WEgT4Lscy/erkI4fEtkCls4/cYBVAQ2MWSh7WLrFvl6qmrtFMArxX3Z9OyybjyP7hlG2MSsyWvBXpPUPBXS6USpdiTrsYgvfdfKCmKB4WQyaBUZf3LClKQazjEJW+7J5fus1KnThl+gQPSOdR18fvbz400BjnVaAEQhMsgFOs2tWQF+Jwm0KxhADj7rjZjOBgmRYpBe2HNoahAbNurHQnN3bDDLAoVR2rSx8ZIvFii06duJUBdqiJPJHaVU/rk33NLM+cABCttZaBOf2R4dTAohh/sQVfEYgT8Xf7R6GnNDUhe4RCy12jKeeSVelvzWw96F0t5EwczaJF1PRQ9bKWA/YtrkaubpYJrGxdg+Purl0CzSsIPxyIyqleUv4fLBtpFRH+oJLANkPjBeV2KuP5DgoIfXnUbawI5IOSl2VsqiCiHGVH1X0Cl3xeR4C4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(366004)(39860400002)(136003)(346002)(396003)(5660300002)(2906002)(8936002)(38070700005)(66476007)(66946007)(4326008)(76116006)(91956017)(66446008)(66556008)(8676002)(64756008)(86362001)(122000001)(38100700002)(83380400001)(186003)(478600001)(6486002)(316002)(6916009)(41300700001)(33656002)(71200400001)(36756003)(26005)(53546011)(6512007)(6506007)(2616005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Wc4Pt4gL+TEnp+bbxrMzP2Eq4r/Ki2d9mCXXucO5VT1v9kBA9vvLWZky0DqS?=
 =?us-ascii?Q?CvgN4zwI1C+oXlemgnfmTdea5qhaSrKerCYLd2e+PUFXvu5WZ+ZFz0SSfIFk?=
 =?us-ascii?Q?cLqT28NECEA2clE9eQJfL+/tyv725aEjIekt0RF0YLAY+Yf+R2AgztscYVRn?=
 =?us-ascii?Q?P1V+sVJ582ngBH5vWjWermMMufynuZaxe8IHdsXKjwWBY4AJXr8Tn+BAdrVt?=
 =?us-ascii?Q?Nihp0SbOgbJv2NwSNGmVmUr/tOX24wnVbRAULjAUBBBk+M7ympE+Q4ekASL3?=
 =?us-ascii?Q?OihZW7/QOs1VZLcoJvjwXuh1wNJgJz7T53NJxS3THg7bLDkEzcwFdvo1dEHS?=
 =?us-ascii?Q?f2bVQoiQN1gIW/PSIbzGggzcoc/JiaGzEBY0Di17/bdUq8w1uAiUFZeliOn3?=
 =?us-ascii?Q?AaR9Se9ULREBNFkGc/AFTFQW4jUGtq6T3KpZxnc4chLD4LOY3u0H1AO5Nuxy?=
 =?us-ascii?Q?wjTqneCTuhhfdLmQRtdgxSNMc8fIgKJW9KZsuFa9Lg16/XcWO8FRS5OoIE43?=
 =?us-ascii?Q?viujQLOTfFBuwxycJ5Nh4ISXei1Z8RdKr2pwGsd1tolNmha8jdreXPdXRkh3?=
 =?us-ascii?Q?UOWK7KwIFhaSMd1cumq85NIBeZedsGJlS52vLyIgTlK6eNML/98rXrR3h5C0?=
 =?us-ascii?Q?avrNmEbM2nNmZXpzB4sy5RHAY3ZWCs1P/ilTLPMXaAgERXe906e+Ko08y2LQ?=
 =?us-ascii?Q?Q33l+4/CfhoW6ZYWtk4FVGMa/zGeatQXoWcOWIVqH+TzglwMC/GVby9MWcUW?=
 =?us-ascii?Q?7S04obz+CZ8GSJ1suVPYC1+wCDS3279ZeUl3aLbh5TaP23w6ZG6cbhF5EfMm?=
 =?us-ascii?Q?tc6eovECR00tVbGgc6WrhvTJfaqS0UoBR8TdG5vzSZ2tX7tfDTOCiKsNGPMc?=
 =?us-ascii?Q?O+lvRFoOlrQWzV31y28BsCpZSNNHAE5oRgtEWjvAKZC4Aj/bPY8jObfBhZNY?=
 =?us-ascii?Q?X9cxPxg0QyPlD5rPW6x+z2sZQjfciNEOf3oGuAOuK7jt+62khF4cs341Gv5S?=
 =?us-ascii?Q?8Ypw2L84+3mMf7mk6Z651JH43UmChXnWCO+KjTYmygdOa8RbW+1CDQ9x3UZa?=
 =?us-ascii?Q?kQWuoUoriUDaVWPRWN/SRHmzZ8ZwT/ayEsKoTfkaWhVBhZJHlrbWllS8i6Jc?=
 =?us-ascii?Q?zfuvcHjayRsz9A0MSE976HZth1kreY4mBQbBb5iMC7fAcHFjEpAp9+jLklBN?=
 =?us-ascii?Q?CHXJeTayXDP7G1JIrGWiUoAkDtfY506NyP/57rkvPRPMWjfQrledc/KnSjpM?=
 =?us-ascii?Q?xeQz3JONY4TmTFXm09K0ojG0FFAvICPiBD43lE2/PW7EkwuLRUfvbbPdz16O?=
 =?us-ascii?Q?3T1G/3B1oGnPHjzXNbp3ZWScYUv3ax6xyUhgzExEO2wSHWP3usIYwq68e8jy?=
 =?us-ascii?Q?h6XDcbG0PsYxsK/AyJMlo3XmmvJgxqX8hZCcagOMyTHfs2wTwi7wYJrogijI?=
 =?us-ascii?Q?nuSjgbq6yJ1+M8KF5yZ/G7XjlgXCo3+TJn0FSkuql22X/lamMmfdrE1r0clz?=
 =?us-ascii?Q?HbB7qlQT/Ug0EmESYSubkHOk2bCH/Lxf4XhzNpVH52ox/a/KkzeWJPyGc5z4?=
 =?us-ascii?Q?ZENgwswySLQ4QdCPULg4I+vtDLZ2oR+zfBjd3UAlsooQ/muuhr+fmsrz4XMX?=
 =?us-ascii?Q?Hg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1E8AF6ABB6BBEE4D807CA70B8C273980@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cb3e04c-ae05-4161-8fb3-08da8dd2d299
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2022 17:36:24.2118
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GBCQGwF4JV/inJkGbtURwV+wXdaePH8a7f2zTpDDkzDuaz9o++XFcR1RN4VKIywqEYUReYZJvO0ExALC80myNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4881
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-09-03_08,2022-08-31_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 adultscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2209030090
X-Proofpoint-GUID: CA_fbF-G252vHyh8SzM4Z4-S_xga7yzQ
X-Proofpoint-ORIG-GUID: CA_fbF-G252vHyh8SzM4Z4-S_xga7yzQ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Sep 1, 2022, at 2:33 PM, Anna Schumaker <anna@kernel.org> wrote:
>=20
> Chuck, I tried to add in sparse read support by adding this extra
> change. Unfortunately it leads to a bunch of new failing xfstests. Do
> you have any thoughts about what might be going on? Is the patch okay
> without the splice support?
>=20
> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> index adbff7737c14..e21e6cfd1c6d 100644
> --- a/fs/nfsd/nfs4xdr.c
> +++ b/fs/nfsd/nfs4xdr.c
> @@ -4733,6 +4733,7 @@ static __be32
> nfsd4_encode_read_plus_data(struct nfsd4_compoundres *resp,
> 			    struct nfsd4_read *read)
> {
> +	bool splice_ok =3D test_bit(RQ_SPLICE_OK, &resp->rqstp->rq_flags);
> 	unsigned long maxcount;
> 	struct xdr_stream *xdr =3D resp->xdr;
> 	struct file *file =3D read->rd_nf->nf_file;
> @@ -4747,7 +4748,10 @@ nfsd4_encode_read_plus_data(struct nfsd4_compoundr=
es *resp,
> 	maxcount =3D min_t(unsigned long, read->rd_length,
> 			 (xdr->buf->buflen - xdr->buf->len));
>=20
> -	nfserr =3D nfsd4_encode_readv(resp, read, file, maxcount);
> +	if (file->f_op->splice_read && splice_ok)
> +		nfserr =3D nfsd4_encode_splice_read(resp, read, file, maxcount);
> +	else
> +		nfserr =3D nfsd4_encode_readv(resp, read, file, maxcount)
> 	if (nfserr)
> 		return nfserr;

I applied the above change to a test server, and was able to reproduce
a bunch of new test failures when using NFSv4.2. I confirmed using nfsd
tracepoints that splice read and READ_PLUS is being used.

I then expanded the test. When using an XFS-based export, I reproduced
the failures. But I was not able to reproduce these failures with
exports based on tmpfs, btrfs, or ext4. Again, I confirmed using nfsd
tracepoints that splice read was being used, and mountstats on my
client showed READ_PLUS is being used.

Then I tried testing the XFS-backed export with NFSv4.1, and found
that most of the failures appeared again. Once again, I confirmed
using nfsd tracepoints that splice read is being used during the tests.

Can you confirm that you see test failures with NFSv4.1 and XFS but
not with NFSv4.2 / READ_PLUS with btrfs, ext4, or tmpfs?


--
Chuck Lever




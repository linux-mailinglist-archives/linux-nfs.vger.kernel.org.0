Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1594D4D8724
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Mar 2022 15:43:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238554AbiCNOoU (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 14 Mar 2022 10:44:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240201AbiCNOoR (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 14 Mar 2022 10:44:17 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9502764E0;
        Mon, 14 Mar 2022 07:43:03 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22ECgbQa028752;
        Mon, 14 Mar 2022 14:43:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=c/0X0eUg4GpUYhA+ZgHWsYsMTqmUrRlw2NdJs9aIBgc=;
 b=GTjyGsfPUbp7q2u2w3i4JEFuzFfpz5Ut0Chvod2c98dmDW6hP7CvjznafkpKTBtx23bb
 BMIUW+LDigv2Y1mzJj2AHvrkU9Jf+1vMVGS2nrdtw/KKXSZh7G9tdAsjVYVQlKkb8lad
 DURfPCbEJvppZaqpZsYt7I4EbJHC7EHe0w26zSuTsI362tGbajl+5eQ3DnL9znYURszo
 6b7FyLRcX01t5eMtZLwui4Lqo0aR4K5fAeNxgsARLEKxeJexSRRNathJLMFk/Lh+qv9/
 KmPt149GwpmNJwaeB4TkhniAESrz8/nxVGd2JG9K8Qh8mWUn8svp26gs7GG1rqcbKTKi +Q== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3et5xwgcdy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Mar 2022 14:43:02 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22EEfGaI165337;
        Mon, 14 Mar 2022 14:43:01 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2176.outbound.protection.outlook.com [104.47.58.176])
        by userp3020.oracle.com with ESMTP id 3et656syky-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Mar 2022 14:43:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nuul1yLezhNSMfpLmRQDBdinJvn3cBnuztvZEFDGcx9LYjOQ6eB6tYVIwzMjw+HI4rBKzDYT2CXlh8YM3gRh6JFSMASKetems17hQVtPIjb9BSp9FqyH7w2ANVUDMwx/MKucULlPIV8tOjRjo4LdwHTJZVhpWbKa2NqWpQO4eWM7SBADQBoNnBxseckBCyEuLrY3n+BMGeMJB4Ls+pHXbHZbHaTRjo1NZ5Rmy9T2jzEfCH9trKuiunER4ZRnzRfVyIibPLBF5MyWWF/NMcn9Fl6mJLHTKdVk0MDIWE0fnq7/VliZSKIE6dGd9zzyEtWMHAmVwRKTHgyRfApqlXYSLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c/0X0eUg4GpUYhA+ZgHWsYsMTqmUrRlw2NdJs9aIBgc=;
 b=UOYJxkxrIwLfL7JW0dxpiGw6y6v3vSYArgGulxRmA9x9ToPZtGrPl5xStPyklXEp/lA09KI1gvoG7Aup95teK1PMOWoPnQ2HTfccIGdYjszOmYS7G7zyU/wf2VWdEsakaGtdUIMiPS5YqcpMuejFddMCkNtKb9z8PcTZe8GJqWO7R41eXpUeOtrLh53CjKvAqdnaTlXY4LROk3ypaITa2qesyNifXxcw2GaStN9ekeJdfW8lRJf8ADudMoyTRmQmfLGrrpyqNRlGIUk7w/NMnYapuwVDGMKbnXUVcKMjbwOopMLyi2nOggOpk9kQ+6bPhaab/N6gNbU0Ec6Uq9pACQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c/0X0eUg4GpUYhA+ZgHWsYsMTqmUrRlw2NdJs9aIBgc=;
 b=URsK0BVi8ruGhkkd9iVQiNMiO37KwyGwJLuUuueLz1rB10bI3Ur4mv8bFLBTpOI+XwnH9G4prOjgJceO0HK6s6KodaoS6wwOw/wS8j/N0aXgzaaTQW73TDxc8I1WJyRmBJDdPYPScyWIwkNaDceIgqPnWX3IR1DTLop6UQjJbOs=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MW4PR10MB5703.namprd10.prod.outlook.com (2603:10b6:303:18d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.26; Mon, 14 Mar
 2022 14:42:59 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::94c5:42b1:5147:b6f0]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::94c5:42b1:5147:b6f0%5]) with mapi id 15.20.5061.028; Mon, 14 Mar 2022
 14:42:59 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: Re: [PATCH] NFSD: check for negative "len" values in
 nfssvc_decode_writeargs()
Thread-Topic: [PATCH] NFSD: check for negative "len" values in
 nfssvc_decode_writeargs()
Thread-Index: AQHYN6y/Zj/ZEDDMAkSOXTxZGel4ray+9D4A
Date:   Mon, 14 Mar 2022 14:42:58 +0000
Message-ID: <6F04F280-5267-4D12-8053-2074703DBE6B@oracle.com>
References: <20220314140635.GD30883@kili>
In-Reply-To: <20220314140635.GD30883@kili>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 54e0dbb2-b36b-47e5-441d-08da05c8ef27
x-ms-traffictypediagnostic: MW4PR10MB5703:EE_
x-microsoft-antispam-prvs: <MW4PR10MB5703F093B6E471FBE7EB4DEB930F9@MW4PR10MB5703.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iupkQeVgHjD2rW60Np/Ln95HlRoVgxSokFGt5rOwdZqDIOuCdQq2EBlCoQryW2cmleCHYhdfjnZNmVyc8Wsfn3TCKfgjdtqMHGzTei2ooG8K8uK4oFI3LAHJK5GCYZTphFu/mzqiufCdKKwik6B9HZ4oyAACQSm4wGWiSIkamC48mSFxU4Dfsnt5ZKyTa60aO8Bde190urTkSs2GxnY3yelg+cH7NeJzTbX83cPL6V7X7Y2qnhyEbwZJnPn7d0AazsbB1IjDCRlCw45+iHAhr6dBRjOAiy3KuPv1Ez1gvFeiKGP+btsk7JzYFvpOAWKXCJ4r8f27BbTsbUQU8RSDd0sLL9/xahKdARKbWIsFZfkJRpBRUKenw/PQ30Ata+SAhf/HwV814Y5m9cbYibpfyotw67ijDdX5QE/9sD2cEXZpAL9rxO24+/acoN8B51rzJQN506eQ3d5NeORYODVkR8rRBvjHuk4QY0BuNLo9hLblKqRpWxrh1k4a0t0zS0xKOi6wbuqBUbE+X1RNoLbjCMtDRd+r98MdFKe4I70Tk0Hh1MP5ub0ihIc3BgTyqu7WlSAYMSmbGaYKd8RLIi6UNLQjVUDPTa2SypRkL/aq1Dk+M2CD3huLNqUbWu9h5iHXvNb0bG+DuDA2s7es36mgqewD5PZXFX6x2KyQAm8KgEc0lWDX1l8710ej9nC4hXyUKIhR592+MTrM4xyM+ILELlj14xKtL2vVo3DiXFT9BCMCd+RyoA4nzF02r0BrF8DyDC6YNEvR5xxlRmX/FKWZ9xp4xmlGzTVM+aNSe3ecNfMI5hyt/lOy9SryoFDlTyO9
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(54906003)(37006003)(53546011)(6636002)(76116006)(91956017)(316002)(5660300002)(2906002)(71200400001)(2616005)(186003)(83380400001)(26005)(6512007)(6506007)(86362001)(107886003)(38070700005)(33656002)(38100700002)(966005)(508600001)(64756008)(36756003)(6486002)(8676002)(66556008)(66946007)(122000001)(450100002)(66476007)(66446008)(8936002)(4326008)(6862004)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?FWp1AJUuB2WUGAwtysn2HzeBXFrKPYs7gvjwoFDuyROdVwLsA5UqiOV2ySWu?=
 =?us-ascii?Q?VHvGoFsUlW5pjjvx+KI7kdmEcY01D/n0mbyFTdiqXAGWJZ0iklG8lJxpnUYS?=
 =?us-ascii?Q?RnT+Kn8ymPwYs362Qhcdrl0B8hMXc/GeWr28UJ62ejhuttO6jBqz425ZTXle?=
 =?us-ascii?Q?dl2b7kt1gIaVGj8LNl1Y+dZvuqZfB5vYL2Dp5ntT91P+TdfCwmGhTyvQMAyC?=
 =?us-ascii?Q?ivjx5SfNUO309ivBwuM/yY4rR04cebgb0kUUUsz1Gct8/66Tug8voXtSI6vJ?=
 =?us-ascii?Q?rW7v3efFJIn6DJiYdjv80E2tx3tJ2yWTcjoY7pVnYC64oHDI820mM/U2uuw0?=
 =?us-ascii?Q?Xp/C8TKLUogAhR2e+K0+vij83ENt4YgnXmdv0tjFXlAaN01Idiv9m9DUueqA?=
 =?us-ascii?Q?WrF3DVVlogt5ySYld83iUjLtyY8z5Dj+MKOIXOJmNZ1skx4kzvXvMkT+sl2G?=
 =?us-ascii?Q?QNzp4GMVAOEok5B1b/jxqFVDaWwDA//BU9qnEKoZInnOjlj8R+y+9rcM0nUv?=
 =?us-ascii?Q?MrAZF3ZR60SzJi5jHqDUKimkPTOlmbV/4IDOz2m0kcXJNh76FwhhSKgrnJbj?=
 =?us-ascii?Q?cUrazR2ttyF3l/930/xDsKNmf6bo3hZEeJ1LBAmKWoQW2ibtByNLR1ZdFLdT?=
 =?us-ascii?Q?v3PjokoSqQINdwSbxLecDy8P/mQGWkSYJTUa3g15ZBh0gVsdN93+/W/C7LA3?=
 =?us-ascii?Q?aFiuE4GxbL5GVGt2YaHgK3B9PjNdVqSm02HUBJf0uuQIo60li+wmGqaNSvHt?=
 =?us-ascii?Q?62AH85f3BxVtt2Q1WKYOwMQ54yXmbRjwS6g4iTY5ywz3qbvLU2+VGBKmjQi5?=
 =?us-ascii?Q?4Q+x7bmurT1zPlcKNxzctQ+J69Fyg+MgDBBk+2Iy05/4P0fkH1NiwVlFhnpw?=
 =?us-ascii?Q?jKd8OgwY77tWN1KIGhI1LpcxfPXahxv7yUUmwdoy5mUd8sgKBIirCUphuQxz?=
 =?us-ascii?Q?ExUHayk6QlN4HJKLXtSv+EX9bHFG9iLGZ0SR6a85RLvrBOhK7qNTJgFN4VGA?=
 =?us-ascii?Q?c1UXnXMQH71gpmD0tJyNFWJBcz7QqKX3CMMV3WdlkMqLlrmI1L6vtizu0Hf9?=
 =?us-ascii?Q?n1a5PhAv5d7kzQTCbh6D1dPF2oZR4fJKO548SUOoOQe59S2DRWKh+BTCePKz?=
 =?us-ascii?Q?TpDGPJR7M2skv+9/UOMwrj4j9IqBDiZ9clhIyIfu+AnViVq/wkSK6n9SZKlW?=
 =?us-ascii?Q?0c9YZfygZmYQyxXbmmc8uNUjiVVfWQJZOJQMnHpeqJ/BOUmRK6IB4EEYCSZT?=
 =?us-ascii?Q?zaCMwKEwE6qYRhbTE/L6g34aaxfqNC15E0a/Nl02rXKyfbl8hvcjLE2JuZ2N?=
 =?us-ascii?Q?2HXN31kykvcXNJp2F21Way00oOmSE7iVkJqz7BAm/sweyyR5NWYjcrwFvIcW?=
 =?us-ascii?Q?6RWDdqMAF2UOE7tz+PheamMWjwkoU+G7d04K8/F6KkZsmpqzLtSwmpo2mnkd?=
 =?us-ascii?Q?/bnknVlvmW4X5p7FzHcnfvV/7o8WBGufEPSBbruj31ej3d80k3Lmmg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <EFE4DE3710F15045838D62C7C72C1000@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54e0dbb2-b36b-47e5-441d-08da05c8ef27
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2022 14:42:58.7460
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zpJo+oYIyFC2FymrY4IayHuEWJj84JP82o0wPcezK0jrg7ZB1VvEIJKH44BeQmju1AzVecNR0/fH5e6nLlnjWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5703
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10285 signatures=693139
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 malwarescore=0 adultscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203140092
X-Proofpoint-GUID: pVtWS8k1U50rG8Gb956RO3XK1pC54_87
X-Proofpoint-ORIG-GUID: pVtWS8k1U50rG8Gb956RO3XK1pC54_87
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Dan-

> On Mar 14, 2022, at 10:06 AM, Dan Carpenter <dan.carpenter@oracle.com> wr=
ote:
>=20
> This code checks the upper bound of "len" but it needs to check for
> negative values as well.

It doesn't check because nfsd3_writeargs::len is a __u32,
and the NFSv2 code here was copied from that assuming that
nfsd_writeargs::len had the same signage. This is because...

https://datatracker.ietf.org/doc/html/rfc1832#section-3.13 says
that the count field in a variable-length array is supposed to
be unsigned.

Thus IMO nfsd_writeargs::len should be changed to __u32
instead of adding the extra negativity check.

If you resend, make sure the format specifier in the dprintk()
at the top of nfsd_proc_write() is adjusted accordingly.


> Fixes: a51b5b737a0b ("NFSD: Update the NFSv2 WRITE argument decoder to us=
e struct xdr_stream")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
> From static analysis and I am not sure of the implications of this bug.

xdr_stream_subsegment() takes an unsigned int as its third
parameter. A large out-of-bounds value would cause it to return
false, so this bug should have no impact.

The use of "int" for the nfsd_writeargs::len field goes back
to before the git era, so I suppose just "Cc: stable" is adequate.


> fs/nfsd/nfsxdr.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/fs/nfsd/nfsxdr.c b/fs/nfsd/nfsxdr.c
> index aba8520b4b8b..a9f80e30320e 100644
> --- a/fs/nfsd/nfsxdr.c
> +++ b/fs/nfsd/nfsxdr.c
> @@ -336,7 +336,7 @@ nfssvc_decode_writeargs(struct svc_rqst *rqstp, struc=
t xdr_stream *xdr)
> 	/* opaque data */
> 	if (xdr_stream_decode_u32(xdr, &args->len) < 0)
> 		return false;
> -	if (args->len > NFSSVC_MAXBLKSIZE_V2)
> +	if (args->len < 0 || args->len > NFSSVC_MAXBLKSIZE_V2)
> 		return false;
> 	if (!xdr_stream_subsegment(xdr, &args->payload, args->len))
> 		return false;
> --=20
> 2.20.1
>=20

--
Chuck Lever




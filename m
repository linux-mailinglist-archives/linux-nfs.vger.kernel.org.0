Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FE0F4C4D08
	for <lists+linux-nfs@lfdr.de>; Fri, 25 Feb 2022 18:57:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230506AbiBYR6L (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 25 Feb 2022 12:58:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbiBYR6K (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 25 Feb 2022 12:58:10 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C40413152A
        for <linux-nfs@vger.kernel.org>; Fri, 25 Feb 2022 09:57:35 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21PHs0Sl029458;
        Fri, 25 Feb 2022 17:57:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=TNz01RM2OgTCuug5o4mgwI2k15Lc7oF55qHox3SFgjI=;
 b=igDF7b/6zAJOa1Vn5vjhu6tSGJj9Q0VV0j122kEdR2cUz4EbqOnY4qUp3nkR43uxbPx9
 z4lYSdiSM2iJjr/eRz8smoP8lIJviLGJDxM8JOufUMTdG2Jutq+7kwqioxhHzc+4NhyF
 64TJv+/UldZujNKxBzo/7Os2X5TiBJo2XYt0Nuy7tXgE4wv10lSHokUbPSA7vIcTUh2X
 Sl/42Q93QXT8ptb4/EXUID447vgH6nb0KR58eJbCcMM7H5U9zp6V2QSKwxO0ZnzYBLJ2
 KHCUCSYImYbEm9Xq2REz3WiHmcgE0pWAqZ/8GRPQaQ5wCuRR7jmsiEAoxhf/vVndMLGu qQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3eey5dhg2f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Feb 2022 17:57:33 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21PHf2ai120522;
        Fri, 25 Feb 2022 17:57:33 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2103.outbound.protection.outlook.com [104.47.58.103])
        by aserp3030.oracle.com with ESMTP id 3eapkn3xud-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Feb 2022 17:57:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DpKOj9bxv81IPU3hq4LfjK6T5b8/VJMnzXpNhjF3OXL0Aws2KbOxFQPZ+g5nuWmBn+DhGGYq6eWZSWj1pid5rtBSGnpbvmLkEE2HPcdSCt9RbdX156BMMkk1SqKnk52HelYkqJPm3p7RziMYdbfTPzYoZpBxyX81mxqiZpqHOgV8/BJok2EGKsBW2HuHA07SW8Gh0S6EH0Nzk8S8IBqpb1e1+AGLN3kJz7/9xbbDUh+M5ElOUFB7Ders6+nehYUnbVmeqsLHG7cS55DC1vxIoml+KvaXERFB3PBAvjyudUN/QQKGZlWc1C0PIZ+ZGqFiLuH/tO3Zc+q2vUNBHWdH9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TNz01RM2OgTCuug5o4mgwI2k15Lc7oF55qHox3SFgjI=;
 b=USjslI73IGpV+2ELfoGNrZCPZFqFvUAVGzOLdrcZUZZ1Wr5beWwVot3HGsPG6iGBoB4RB+51A0ch+Aj1CPTfu5jy4xch/E0ruLG0qbVM8gdwh2Y+cw/x5dp+hU/Bow8gWlfyA785nDlOjF4eX6Nzr2sKbBMRpCtW7pToRVNeyd5izWGAVO+P1JCfrSc4o3mpme2WGNm0gFxCb8Dnr3ks64MnxY0WWKEdxG/xUbru6Rdbf0GETIx4xvObwA9j3vpwDWGYxMhXDXkp3Ubj0+pQFyD3NRctgXjA9Ymh3Ys+UN7ccK/Ab8pGK4+US9KoQId59gQXZ8YPEe9OEAzHzrdONA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TNz01RM2OgTCuug5o4mgwI2k15Lc7oF55qHox3SFgjI=;
 b=SkOWeOT58thvqEhreKFf9fmpdndnEPn8QigA7HCgPfY0u9AIcQwIy/BEUx0Kldqe3vKohWpS0Cw4nzF9cxReIyhFI6nHtSU5Rs0R/d27reeNU1jfsPfTuy4yCzrLbAL422geWR5tjJYnk/47a2+op0Ooa+eAQUSTV+SJ19rr85A=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MN2PR10MB4013.namprd10.prod.outlook.com (2603:10b6:208:185::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22; Fri, 25 Feb
 2022 17:57:30 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::29c0:c62f:cba3:510e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::29c0:c62f:cba3:510e%9]) with mapi id 15.20.5017.025; Fri, 25 Feb 2022
 17:57:30 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Dai Ngo <dai.ngo@oracle.com>
CC:     Bruce Fields <bfields@fieldses.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH RFC v14 04/10] NFSD: Update nfs4_get_vfs_file() to handle
 courtesy clients
Thread-Topic: [PATCH RFC v14 04/10] NFSD: Update nfs4_get_vfs_file() to handle
 courtesy clients
Thread-Index: AQHYKOGE55LpO5GXrE6/QR9iTsnnSKykkIuA
Date:   Fri, 25 Feb 2022 17:57:30 +0000
Message-ID: <18A7CDF9-74A3-42D0-AC32-F7B6CAF32D3B@oracle.com>
References: <1645640197-1725-1-git-send-email-dai.ngo@oracle.com>
 <1645640197-1725-5-git-send-email-dai.ngo@oracle.com>
In-Reply-To: <1645640197-1725-5-git-send-email-dai.ngo@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2cdd516c-72da-4dd0-31ef-08d9f8884ac6
x-ms-traffictypediagnostic: MN2PR10MB4013:EE_
x-microsoft-antispam-prvs: <MN2PR10MB40137403D02A4BB6B88BBAB4933E9@MN2PR10MB4013.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LpWeuVFxqIwEdz124IFzESytraBiFySWgEmLX7kH21yXoSnJ3TznPXH+mc6EkksQJXdej+2hKt4TB8s+yorI5Es2pcoc7U7MGyL0AlPnqLjPhxndjuNjOkdGvXv654r6vxza124RntPOrIZgcprdu4LIg+IFvgH1fjV/QuBpYiHN2iI4eU4bLcAKQmamEvCIqM8v7M1GWMRh0AW7LM3fDaJmEC9RDbpiXja4tEvG8fGw+k1c/8V/xY4PQO0TtJLQxHTeyuRIi5Ny6+NBnu0ljcmStV6iq7HXJKd0sbRuys9+96i24OqoersiF21kBTpgH5GfkH0eAGQaLH++BPN81gl6hINn26Wjlidxu/vGP0kV5+2YLJe42FAbHC4zkK7ME5sc8OstRmEoy6oYafa8jVJkbPrftiaH9EK1S0GPQYdu4B00p61nzMTXQtPh4ZRlwT+y9zNhJaxB0bQhZaaCYJ/tBRzAWdFJ0md1P+VLiKrNQzzxevm+WqOQOCFtUOYvZfs7STdXCuNn/mnm2Jv2A/9yKWeFGpRantkfiwjHSiAq4eEVKOU4+gpEDIWqboQDN6tLY9+9sqgf+y0+XomKbvtlWAw1UAMyTHOmVeVM2follBrrefYROHBwBxNn1gWHp2PF+kR0xgnqYnxGGVkNZfp0MPdsQEs/pszUrsQ5Eqr5LPIr1kGudIOkNL9GguVZRIX4GbDW7A22botQ3BmujMQRZe9rH/cNu/yUOsTc605U/wSkQ5xZLWWI2WAN6wjI
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(26005)(38100700002)(38070700005)(122000001)(186003)(83380400001)(86362001)(4326008)(6862004)(8936002)(5660300002)(91956017)(8676002)(66556008)(66476007)(66446008)(64756008)(76116006)(66946007)(6636002)(316002)(15650500001)(36756003)(37006003)(2906002)(71200400001)(6506007)(53546011)(508600001)(2616005)(6512007)(33656002)(54906003)(6486002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?yVt7SXU0jZ5YbpnVqYiC27AE4+3dBkFExZlnZMHYE0l4Ylv449ER51/MB59V?=
 =?us-ascii?Q?UsPS9tUsBR/mDfD9ExEybye8X/aacvuRMCzNVAoRt3FKuXB8oLaaKZsq5n45?=
 =?us-ascii?Q?NY31JdbT/kSsv526YLF6Qv2cU0qdVPFReO0sMDej5julHZ0f3C9KL1RG+SGw?=
 =?us-ascii?Q?69YfuZdS7OlcHrOL8S//SnqeWlaO3AVW/zMNUQWVAxKejNjuYdWHO4kIqJQ5?=
 =?us-ascii?Q?77JrYlS5Bnt0+KZKiIYGkL5wtGgtP2xH+XQ0OtMaYyfuQ4vMRbfcV/wAGqT2?=
 =?us-ascii?Q?0TQngUoScbyjM/tYKgEZHLrx39aiuDXCiKALTPrfBiD2/TdEFlvZn3L7D85H?=
 =?us-ascii?Q?seIEubNbnQkJnnxgcno2DevPwQrrY/gX6cBBsrBG0tdaa6bQQaQHp40hEeZw?=
 =?us-ascii?Q?HnrPcuE8H4lpxSGS+SnAsKSFAc4t0xYV2cRuBlXnPbxikwN8JL85AwUJx1iy?=
 =?us-ascii?Q?ljM3SlYYxwTPg2+tkQnuPQboxasOrM2s6EFrv3tnb9eGdJ0y7l8R91j2B3Ff?=
 =?us-ascii?Q?tLg6KPJlpAjAVFZW39y0m2T5GEvB3XLdA8Jue98et7d4GwFdRQSXs/UGUdMC?=
 =?us-ascii?Q?N1+Vb72mcmeAOjX4dsEaYXTbV1W9X6LzsLasCmU+/FMFJmXQcETyKRLS3Y5V?=
 =?us-ascii?Q?guXhyAJ4OKwU5DspmvPVnDbuDoJxNs5fPudK6HNCsczwXMF+7NJbtIrMGH0I?=
 =?us-ascii?Q?FYjJIrF3/iN+EeCHHRiYCz313JZCnYTT4oziZumXykVWmj8mlxDmPdNMUK1n?=
 =?us-ascii?Q?gChCXxeLuzVgxZN5e/8MOkJm+yOPMJsDJY/cDz1KPJglZ+urE5CbDl2iHW/U?=
 =?us-ascii?Q?wNMd0BjbVa/ltr1QsRoo3fI6s7i9F2q0JHJsEePX7+Psu9gTTuDmvyEGQnmR?=
 =?us-ascii?Q?0lYm4HQjYxxijQ+TzL/mCrP5+/1GAsCG5+V9nG+85XIdkZh/Ohbg1QnyBfwP?=
 =?us-ascii?Q?TucWtmScQh4ZmR6S0jCHxKwBaFCREyMe3xf0zWSw3u1zt/sahEr+Yoknqvzn?=
 =?us-ascii?Q?ikuH91ikh4rhunmpQPooDYE2xyFUKe5NGuODmOJt+N1p8Lxpx6xoGqxrDDmr?=
 =?us-ascii?Q?Lil8wdLCU9vnKY2sXPn3Y26raV6+hs8SQy725rZZ0r2ol5mllxa2qY10GD8r?=
 =?us-ascii?Q?ErSwWJ6K6tmfUxYgUahp4T09T5bVTODkbiBC8teqC9f1VVM8rPMxiq338HRr?=
 =?us-ascii?Q?1ZgrnGK8cqfsnMfrq7haS4JFGDcTcVlWjSJHXFH2Jy9tMqGyu9Z87MSdsrvM?=
 =?us-ascii?Q?o5oraNoUjZpQqPRQIi32yyeqvps6UafMDJmBRhBGbzJqZzgXsbsvTaq6XHZ7?=
 =?us-ascii?Q?J8J2EFV7j5wkI30GXLgdcdWK22C6AmhGjAg1y5LP63k2OaoSZii6imgYY4aE?=
 =?us-ascii?Q?PN++8B+vx0zfi2V6Hm61K60q/pljNERqcpXoqiwtcbNe+FiYgkSjE75enN5Q?=
 =?us-ascii?Q?1H4ImSy9bKdY9IQ5gm/HgVf7Hpk8BimlcCABE7TUncf6QQr+dDC7LEd6gi2e?=
 =?us-ascii?Q?Fz7YTntXrzv+zecZ7BUVq1PiRkjBFD189M8nraijdCht06eudLYf1NsFBwwk?=
 =?us-ascii?Q?qSGlpBBqkqSxw8G4FUAyIEXAYQKd9xdAyMVguJY1m+A80ggzT3kV2CTECMT2?=
 =?us-ascii?Q?4hoImuTVicUrAKnggRVMDOw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <025CD4F8E3B1D544AB95E5A91C624033@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cdd516c-72da-4dd0-31ef-08d9f8884ac6
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2022 17:57:30.2285
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /xFMEhzhw6EVCnTrEb5naESYnZZ7QyJAAb6oThC51jJRYYbvYNjQuT6fZRAVjFcnB52QraXdWP2IYcOQEc840w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4013
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10268 signatures=684655
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 mlxscore=0
 spamscore=0 mlxlogscore=999 adultscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202250101
X-Proofpoint-GUID: pBCwEU59FqTRvLzdFHE8JXFGO-fHgeEn
X-Proofpoint-ORIG-GUID: pBCwEU59FqTRvLzdFHE8JXFGO-fHgeEn
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Feb 23, 2022, at 1:16 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>=20
> Update nfs4_get_vfs_file() to handle share reservation conflict
> with courtesy client. If share/access check fails with share
> denied then check if the conflict was caused by courtesy clients.
> If that's the case then set CLIENT_EXPIRED flag to expire the
> courtesy clients and allow nfs4_get_vfs_file to continue.
> Client with CLIENT_EXPIRED is expired by the laundromat.
>=20
> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>

I'm still getting my head around this, but there are
some items that can be addressed now, below.


> ---
> fs/nfsd/nfs4state.c | 106 +++++++++++++++++++++++++++++++++++++++++++++++=
+----
> 1 file changed, 99 insertions(+), 7 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 542a13676c91..1ffe7bafe90b 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -4965,9 +4965,87 @@ nfsd4_truncate(struct svc_rqst *rqstp, struct svc_=
fh *fh,
> 	return nfsd_setattr(rqstp, fh, &iattr, 0, (time64_t)0);
> }
>=20
> +static bool
> +nfs4_check_access_deny_bmap(struct nfs4_ol_stateid *stp, u32 access,
> +			bool share_access)
> +{
> +	if (share_access) {
> +		if (!stp->st_deny_bmap)
> +			return false;
> +
> +		if ((stp->st_deny_bmap & (1 << NFS4_SHARE_DENY_BOTH)) ||
> +			(access & NFS4_SHARE_ACCESS_READ &&
> +				stp->st_deny_bmap & (1 << NFS4_SHARE_DENY_READ)) ||
> +			(access & NFS4_SHARE_ACCESS_WRITE &&
> +				stp->st_deny_bmap & (1 << NFS4_SHARE_DENY_WRITE))) {
> +			return true;
> +		}
> +		return false;
> +	}
> +	if ((access & NFS4_SHARE_DENY_BOTH) ||
> +		(access & NFS4_SHARE_DENY_READ &&
> +			stp->st_access_bmap & (1 << NFS4_SHARE_ACCESS_READ)) ||
> +		(access & NFS4_SHARE_DENY_WRITE &&
> +			stp->st_access_bmap & (1 << NFS4_SHARE_ACCESS_WRITE))) {
> +		return true;
> +	}
> +	return false;
> +}
> +
> +/*
> + * Check whether nfserr_share_denied should be returned.

This function is doing more than adjusting a return code,
now that I'm reading it more carefully. How about "Check
whether courtesy clients have conflicting access."


> + *
> + * access:  is op_share_access if share_access is true.
> + *	    Check if access mode, op_share_access, would conflict with
> + *	    the current deny mode of the file 'fp'.
> + * access:  is op_share_deny if share_access is false.
> + *	    Check if the deny mode, op_share_deny, would conflict with
> + *	    current access of the file 'fp'.
> + * stp:     skip checking this entry.
> + * new_stp: normal open, not open upgrade.
> + *
> + * Function returns:
> + *	true   - access/deny mode conflict with normal client.
> + *	false  - no conflict or conflict with courtesy client(s) is resolved.
> + */
> +static bool
> +nfs4_conflict_clients(struct nfs4_file *fp, bool new_stp,
> +		struct nfs4_ol_stateid *stp, u32 access, bool share_access)

Functions that are called with locks held are usually
suffixed with "_locked" -- this one should be too.

A better name might be "nfs4_resolve_deny_conflicts_locked".


> +{
> +	struct nfs4_ol_stateid *st;
> +	struct nfs4_client *cl;

Use "clp" to be consistent with other areas of the code.


> +	bool conflict =3D false;
> +
> +	lockdep_assert_held(&fp->fi_lock);
> +	list_for_each_entry(st, &fp->fi_stateids, st_perfile) {
> +		if (st->st_openstp || (st =3D=3D stp && new_stp) ||
> +			(!nfs4_check_access_deny_bmap(st,
> +					access, share_access)))
> +			continue;
> +
> +		/* need to sync with courtesy client trying to reconnect */
> +		cl =3D st->st_stid.sc_client;
> +		spin_lock(&cl->cl_cs_lock);
> +		if (test_bit(NFSD4_CLIENT_EXPIRED, &cl->cl_flags)) {
> +			spin_unlock(&cl->cl_cs_lock);
> +			continue;
> +		}
> +		if (test_bit(NFSD4_CLIENT_COURTESY, &cl->cl_flags)) {
> +			set_bit(NFSD4_CLIENT_EXPIRED, &cl->cl_flags);
> +			spin_unlock(&cl->cl_cs_lock);
> +			continue;
> +		}
> +		/* conflict not caused by courtesy client */
> +		spin_unlock(&cl->cl_cs_lock);

I think I'm seeing similar code as this in some of the
other patches. Whereever you can, please deduplicate by
creating a helper function and moving the common code
there.


> +		conflict =3D true;
> +		break;
> +	}
> +	return conflict;
> +}
> +
> static __be32 nfs4_get_vfs_file(struct svc_rqst *rqstp, struct nfs4_file =
*fp,
> 		struct svc_fh *cur_fh, struct nfs4_ol_stateid *stp,
> -		struct nfsd4_open *open)
> +		struct nfsd4_open *open, bool new_stp)
> {
> 	struct nfsd_file *nf =3D NULL;
> 	__be32 status;
> @@ -4983,15 +5061,29 @@ static __be32 nfs4_get_vfs_file(struct svc_rqst *=
rqstp, struct nfs4_file *fp,
> 	 */
> 	status =3D nfs4_file_check_deny(fp, open->op_share_deny);
> 	if (status !=3D nfs_ok) {
> -		spin_unlock(&fp->fi_lock);
> -		goto out;
> +		if (status !=3D nfserr_share_denied) {
> +			spin_unlock(&fp->fi_lock);
> +			goto out;
> +		}
> +		if (nfs4_conflict_clients(fp, new_stp, stp,
> +				open->op_share_deny, false)) {
> +			spin_unlock(&fp->fi_lock);
> +			goto out;
> +		}
> 	}

Doesn't nfs4_upgrade_open() need to perform the same check?


>=20
> 	/* set access to the file */
> 	status =3D nfs4_file_get_access(fp, open->op_share_access);
> 	if (status !=3D nfs_ok) {
> -		spin_unlock(&fp->fi_lock);
> -		goto out;
> +		if (status !=3D nfserr_share_denied) {
> +			spin_unlock(&fp->fi_lock);
> +			goto out;
> +		}
> +		if (nfs4_conflict_clients(fp, new_stp, stp,
> +				open->op_share_access, true)) {
> +			spin_unlock(&fp->fi_lock);
> +			goto out;
> +		}

This is nfs4_file_get_access()'s only caller. Should the call
to nfs4_conflict_clients() be moved into nfs4_file_get_access() ?


> 	}
>=20
> 	/* Set access bits in stateid */
> @@ -5042,7 +5134,7 @@ nfs4_upgrade_open(struct svc_rqst *rqstp, struct nf=
s4_file *fp, struct svc_fh *c
> 	unsigned char old_deny_bmap =3D stp->st_deny_bmap;
>=20
> 	if (!test_access(open->op_share_access, stp))
> -		return nfs4_get_vfs_file(rqstp, fp, cur_fh, stp, open);
> +		return nfs4_get_vfs_file(rqstp, fp, cur_fh, stp, open, false);
>=20
> 	/* test and set deny mode */
> 	spin_lock(&fp->fi_lock);
> @@ -5391,7 +5483,7 @@ nfsd4_process_open2(struct svc_rqst *rqstp, struct =
svc_fh *current_fh, struct nf
> 			goto out;
> 		}
> 	} else {
> -		status =3D nfs4_get_vfs_file(rqstp, fp, current_fh, stp, open);
> +		status =3D nfs4_get_vfs_file(rqstp, fp, current_fh, stp, open, true);
> 		if (status) {
> 			stp->st_stid.sc_type =3D NFS4_CLOSED_STID;
> 			release_open_stateid(stp);
> --=20
> 2.9.5
>=20

--
Chuck Lever




Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E87E3AD1A3
	for <lists+linux-nfs@lfdr.de>; Fri, 18 Jun 2021 19:59:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233143AbhFRSBb (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 18 Jun 2021 14:01:31 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:44656 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230318AbhFRSB3 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 18 Jun 2021 14:01:29 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15IHk82L027720;
        Fri, 18 Jun 2021 17:59:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=ng/NlIBrXoOxfQEF3nNy2Y9hY51Afz1938qfo2HNvCg=;
 b=dcIgx1ygsHOe1ciOibsegDeAR9QScMZyPa9CFOzMqiS2GuEIMfdBCg2egadvdJ1jdhxQ
 2LAVkRb6OTXXeBvr6NAdWgmC1llCz5pr/ir5xVeJcqqz/h83E6IDPEaIf5qgOrcoOpdX
 KQnMA4uQp6CHVPwDezfm2sqyNTN1XXclL18dLnQHac901HVtTliot+FbhciuEPCWeLov
 4bhGZMQVOifgzLJErAcpMgmBFDBGdidYj+3iuj4Un8YkGmE1cs1WcQQUFK1L5tWglpxZ
 /wq6yDrH+p8BWSqePrVr+gquvh+f2i31qgjgLYtA6WvdSXiaFVRt1MVz4p87JsO4DoQ/ XA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 398xmp06av-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Jun 2021 17:59:16 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15IHjQEt166849;
        Fri, 18 Jun 2021 17:59:15 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2177.outbound.protection.outlook.com [104.47.57.177])
        by aserp3030.oracle.com with ESMTP id 396wawxqfv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Jun 2021 17:59:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YV9R7Fp8HCsB3x5s7Q+n7XwUuioH4qTvqJBkPlh7dNW/q7swo3Uda+TizvewuiSiVCUBeyFhjgHrGxaJEUhgLrwy6Ok2Xv/NpgxYeuxy001CHw17QQqqqvXiBBb/s1J6nLbu5lfNFwM8V81XZxX0V7s6CPAUzC11HO8QXpEpLY/jGLPOECOzLis0bjLuCBWyctszWKs5+rN5FKGzGzSdDeiVXzHJa2QGVPjx00IYVR5dLdDZ2jRYj6RaoAGjVgcJPo6ioMd1Ho2X9tyegt5nQQ2Yi+vQtfpyRWLSyiWBn8EOSZQt6Els5EvcfACAkPM1Uiz4YT94U/3k4/tIC4CC9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ng/NlIBrXoOxfQEF3nNy2Y9hY51Afz1938qfo2HNvCg=;
 b=P4CW3YhHyIZzdcdhUaZ/nPAl3srvfv4cKXCfcBzDASBofHZjbvtJ0vLFuo2pqhRvDi7XOy58c/bMv/+CvCtHbamAz5wEBcUepwPwSAediDUq9me+j9NoLlhmHLXytP/FwlO/h48OS++7/CXEXeuqabknT1xYOeoO0P+nYd2aaE33kGUAlytxSayPQEu+IQme3pvfE3hNdOYlMf630CdLyT9gNal8huZ85JqveJCamIXRtXNU2HBMsTWD+LPoqiedGdNagbD8OZB/DE+oKcDo/2++kspbG45URWZn3XNjDj/x9l5+4V63xzDyUmN5xdGyE5H8uHTSdCFiuhtpKV+Vkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ng/NlIBrXoOxfQEF3nNy2Y9hY51Afz1938qfo2HNvCg=;
 b=GdkzqCVsCBiVyIPolwAKyyZGTGwp9RJ7sP5gLZkc36Ey9VrYsFpGIh9r0bi16serf12hSFcTrcpcwkQPRVK0qMTm7jx81QF/L+kBN8CYvWpzmj2BPfZa0hi5li4MlU483N4BeFmVUE5VnQ/LxghNFvNGNOWbU0+4NRcr7rEZTIY=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BYAPR10MB2920.namprd10.prod.outlook.com (2603:10b6:a03:8f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.15; Fri, 18 Jun
 2021 17:59:13 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::18fc:cb94:ca3:1f94]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::18fc:cb94:ca3:1f94%8]) with mapi id 15.20.4242.021; Fri, 18 Jun 2021
 17:59:13 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     "trondmy@kernel.org" <trondmy@kernel.org>
CC:     Bruce Fields <bfields@redhat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] nfsd: Reduce contention for the nfsd_file nf_rwsem
Thread-Topic: [PATCH] nfsd: Reduce contention for the nfsd_file nf_rwsem
Thread-Index: AQHXY9BFZBFmWOpSekG1W92QMIYbjKsaD6qA
Date:   Fri, 18 Jun 2021 17:59:13 +0000
Message-ID: <C7ADB3D9-D626-4DC2-91FD-E35D62605002@oracle.com>
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
x-ms-office365-filtering-correlation-id: b9ff3914-1941-4532-b4d6-08d93282c85d
x-ms-traffictypediagnostic: BYAPR10MB2920:
x-microsoft-antispam-prvs: <BYAPR10MB29200CBD5FC6F929B72B5749930D9@BYAPR10MB2920.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:792;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Fc7Gl6HMAi9TSwtosLxOUcjDDPEzn9cYheoHkDyNFfzr1sTgkRL/AhpJtme5zlUYZkZB+SUwfN28Ne6j+nf9uex6aC+waPWMC+y2oVwWaC9ml1m3aG2Enbqsg3nYSiM65SvI8cxiYBztzWvhkwEsNiKwRLpdnUcmHla8pqTPo4W2bi73l8DwJAEbKG9Qbz/FB5qcBNoKZdgrRIQL7Bdbgfj+YgzqHrEt84KWw5pX0n3//OI8Dp2OwkI/2K+o0PGVJ7BqRvkv3qsgcc62NmbBYEcC9B/VAxTPPoJ4LdKcPRLVbWSVUgqDF81QTnSFFl/Dpgm8PhwnmNC5M3k/auGwI0JsbMmnh0yWPMYUi7BCgHXtJiQbenIdgM+KMs/HSVFfXVUnZzRPP99fW8a9eIrezE7wdc/DuofqB9/5nuXT/e6VGlJ62pwEmFHfNsL4M9k+PcpPOA9pKXyckOtxjSbV/nDTF3+UlZmNSvlCUog2ECXRXxxrTYG9T6A/Mtr8Dboq8GBIggIRne5LB0ueOoLhTipiJHxZvON2Jq63WUOAklyaQfgGng2JiPre3Q7AqUkcMDSb7R0TzEUqatM8fSJAD7+P3l6+cfRblu0AgGu0TnE6OV6DPacQuuQz4jEUWNoMmkHxw59yFv8j/bNmO5uypg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(396003)(376002)(366004)(346002)(136003)(83380400001)(66476007)(26005)(5660300002)(86362001)(316002)(6506007)(54906003)(66946007)(8676002)(8936002)(2616005)(71200400001)(33656002)(4326008)(186003)(76116006)(91956017)(36756003)(38100700002)(2906002)(6512007)(66446008)(66556008)(64756008)(53546011)(478600001)(122000001)(6486002)(6916009)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7KibRCn52SLuaroy5Hm3uJkCG2c6g6j/Rx3HlGG4pkICgY4MvdJ3RUxIWHWg?=
 =?us-ascii?Q?OaJo2u41T/lzdVoxcrRjZUfIt8zcn/qkpc7oDd+XsgkQ8++BVE0MacbR9L8t?=
 =?us-ascii?Q?EMHp7bMvpaKY6dIfKdrYsU6AT/KepKALYqaahCOwlT4yvwnieCztnWhFDEpD?=
 =?us-ascii?Q?V0dcP+rqBY+Xabi2kgnb9SU9XfIIspBNeFH4OIYibLyjRRinhSHB2DN6qJj5?=
 =?us-ascii?Q?6WV6tHMmQ24fKK1UStuv/2EeE3F8sccYPGyVorNLkU6QO31HyS6wsBbCvuwr?=
 =?us-ascii?Q?BZXnbKy3PgdNH0mv8iWC1gqI7PwrEgikEwUgmsdTD1hAemdmVLj/C2CauWbU?=
 =?us-ascii?Q?1OFpaC0Q7e94HYzzHjPpoi98CIFcxSjckkXYbBO62AvsVVcZI6E2IiXV3F9L?=
 =?us-ascii?Q?4tCYaMBHn3GvzdsW4eW9ACDmnG5NadpuN45FgX/l0IFFIHZB19ntUsUl/7dJ?=
 =?us-ascii?Q?Xzch+NzGWZAK/EGeAXXx5pfBdD1lqpcylc14oTSIfy2Xm5NTyEcAMwjSQlfe?=
 =?us-ascii?Q?jCPzBYjL0ML+b9b+v/vjp01pqcu1KIGpT1h/7rHLMzpSvk45nmDXjaf/7Npv?=
 =?us-ascii?Q?v3Kce9t9nrBo/9UdBqG3BdqaeI96ryuo/Z9QHtQOxdZiOOvbD5d91yXpcJAY?=
 =?us-ascii?Q?/oxrQZnPNt2lKDJBmgiCNMHCeankxFivB+LOof0Ljtc8CrVm5XWuHHMCZKMK?=
 =?us-ascii?Q?16Tz4TafosODyiG//RAhinP93PJ+oOO4UDI6/swj0KcvbEWFaLJkVG4FtrQO?=
 =?us-ascii?Q?S2WccU8fW+0DsvzazaxCvfAJ7PG6XrsNk2fDmt0/icmym0XbGz06dP0cwKPi?=
 =?us-ascii?Q?E4kPBksEhvlhZKoYeF0QgNTVisTVRL/8UnB89eQGWSdLEJ3Yz5es/czts7I2?=
 =?us-ascii?Q?4hvGpDNncyG8jsElHppM5JXwylMOLDy7VPx/EVbWBT/F8arIV0mE+VNn3OFA?=
 =?us-ascii?Q?jfjMknflEwcCeF3O3w2e2jvV/tL9wyAtqNoktnuPhY1KuFOWR4dEuaJ8wV+P?=
 =?us-ascii?Q?q9ZEvD+Ix9UmFi+7EVrTOFnkNQX8erOFAojMqzNLTsV3c0I/P84XBEi/c5A3?=
 =?us-ascii?Q?I7cBZqXCFLjPTgJW2L4WapM4NbqobbUudzRj99AMf1SXGaR40PkyyfkSIWg2?=
 =?us-ascii?Q?Rx70LAMhLxly7o8gOdZygWdmHcUKfZ2rsccrB4OoOx5jgqLnzaL8yS0J1Yw9?=
 =?us-ascii?Q?wXQolt0JhfzsL7RMNLkOxs81jY5hDC7Eq2NDTCCqo1bFxwFxYvDxBrqcVB7W?=
 =?us-ascii?Q?1MHv3g6ALBMUm335nuG1kkDtvQchXA/pe9BiVNcxorF+sm6luZd97ABN1gSm?=
 =?us-ascii?Q?0NrVa+VSIuZTZBt53ClfI7Jy?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <DE3C9A88BDD51D41A940344CD46FE828@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9ff3914-1941-4532-b4d6-08d93282c85d
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2021 17:59:13.7680
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WdrFatVen5tyFzZR2PFGglXwxBb3++iVA9cfD7Qa7K+rOLElIAmYQ9LivIyDT2sPQAouWgdxt96re24CfsH2BA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2920
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10019 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 spamscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106180104
X-Proofpoint-ORIG-GUID: -0ZSoOuMII5RCgjLdZjTAyLUi67-KxUl
X-Proofpoint-GUID: -0ZSoOuMII5RCgjLdZjTAyLUi67-KxUl
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

I'll toss this onto my server over the weekend for some testing.


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




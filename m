Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12E33332EF2
	for <lists+linux-nfs@lfdr.de>; Tue,  9 Mar 2021 20:24:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230425AbhCITXl (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 9 Mar 2021 14:23:41 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:34536 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231496AbhCITXT (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 9 Mar 2021 14:23:19 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 129JIhaf152015;
        Tue, 9 Mar 2021 19:23:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=HKYdalB2GNaLe3m90MoxjGOYkb+LookVD/0YPbBLxwI=;
 b=y63WMZvcmUI66wO/4P6XlSq/Bdyw4GcwaPjcGPRz1PMvIB3y0hxUzU0n3/lYt7EseeD5
 JiZ1LPyQOvu3hnkjKIgSzIC4OXj/qUoyE/dZOF2+IB4QJK1xGvSh2mXLtVCASDTOnrsI
 18/05D82EbzRQcx4U3Dbks5FaWbGQclkWAXIpkIrkUOg5+5UkNdw4ksJUVh/tiicPSsL
 rep5oLM3cv3gDD5VYRdMABMhVXS9nmjuU9+5jPjdnL13DuQschJYSAFov3H48xmDFsXe
 G2TR48XZ/N4FK/CN6aHNo8EeA5nte+G5uYKJw80+P/uCv9u+a5SRtScqZgF+PkziMScB Ag== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 3741pmgjqa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 09 Mar 2021 19:23:16 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 129JLPn5089515;
        Tue, 9 Mar 2021 19:23:15 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2107.outbound.protection.outlook.com [104.47.58.107])
        by userp3030.oracle.com with ESMTP id 374knx959q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 09 Mar 2021 19:23:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ma0xv+eDa/dfAVmqHUBNR9ZpoBJCtYYLE3PHOK2gyTi3qGgMSFl9KHieGCPVYeLJU57yqUiReb9RdSvkfOEBWzeinjl6izkY64qLXT9rmgI8aGfJv+19LowT6dS0wbB6iNeTAoldl1oB06RTOlpwlbQ66S36MfikoFY2rphAx+hVHFWixA4fKwSeY+uTXOjVWS78l0dRtSdWYXhh3hfqSRUfwJtqbTxmCMY4p5AVVGPQeTupTmYGt5yV3PLeqwCD0TjzshjY4KYO+GZIiYEbzXYKuksaL3SdldZCJ7qeKH8qKOKmiMCtaaHmPPfJVLCQ8wjbJsM65wl7z2BuKgoNPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HKYdalB2GNaLe3m90MoxjGOYkb+LookVD/0YPbBLxwI=;
 b=chJs2UpqXE6pkDx8oXPURKXYbMttAyAvRDjM10CC9W6/O4WKFuPJvv7XbvlAde71qztWII1eX/7inMLifd+jQpfZle5CbQI+I+gvK9EF5CVc/glGYHGn3Af3icLzk/GU3UwWmdMI8Y0KrvcA5d7UMjM2Bc4bYYLSIhpijn0ryfbqzc3uFjqKluKLB+al2FCmvzG6YI0bUx6xbcEP8UDbNiuguykMNTDp6qHsS02w9JUnOfBL7sV/3Jk1f8LNYisYHZeLFB5meBQKDM3OcVpfsd/Fiy0L1n6ORIjWHpAFZIEWrTtQC5Vnx0j3BtTTxP0Sn5NSIYaawzPnqpn6MLeEcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HKYdalB2GNaLe3m90MoxjGOYkb+LookVD/0YPbBLxwI=;
 b=QqA0O7Ix9rVopv2FfmikfEhT60ml/e3uxtdHCSVf7PysxAHuChlVnvZSCcbuquscYU0HOTIIQeayA3v29X7VMh+panI7ehdYYlnnOgO1aKfSTlgfLW4gn/PhNgnile1yRUvzHK+Ewj9NrrTesZVivPkSdSf7ESVqyCVAQ28vwAk=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BYAPR10MB3046.namprd10.prod.outlook.com (2603:10b6:a03:8e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Tue, 9 Mar
 2021 19:23:13 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b%4]) with mapi id 15.20.3912.027; Tue, 9 Mar 2021
 19:23:13 +0000
From:   Chuck Lever <chuck.lever@oracle.com>
To:     Olga Kornievskaia <olga.kornievskaia@gmail.com>
CC:     Bruce Fields <bfields@redhat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v3 1/1] NFSD: fix error handling in NFSv4.0 callbacks
Thread-Topic: [PATCH v3 1/1] NFSD: fix error handling in NFSv4.0 callbacks
Thread-Index: AQHXFRFWtrI7LwxgJU2zGAdgZmQJpap8CSiA
Date:   Tue, 9 Mar 2021 19:23:13 +0000
Message-ID: <EAC51290-2EB8-4FE1-BD37-AE035D7BCB6C@oracle.com>
References: <20210309182337.62308-1-olga.kornievskaia@gmail.com>
In-Reply-To: <20210309182337.62308-1-olga.kornievskaia@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8ca62073-c52a-4023-8fd8-08d8e330c8c3
x-ms-traffictypediagnostic: BYAPR10MB3046:
x-microsoft-antispam-prvs: <BYAPR10MB3046A859E5363127DC8ACF2893929@BYAPR10MB3046.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Pcd6JTkc92Ee+BJNlgZFJtUhyc8hZR5N2RrQWA1OJyN48pFjdB/8Weh1qcEERWJ+UfEwGf+eN/XqtdptPjTr4MHsHKUwqpuGuhJ1pL712+KALCHL1/4GOfJvi5eJsD+3DEo25jwJiruGjLXP7VHguW8m51VJM5mOhw/PEbVBQWdc7AxJr1xCw+UAlIc1jcHV7o+Oc7hyap3HLtM7xYUBB6DhsI1qCDao+ynx5rZeZOlICQYo2Dpe3aYTyUsGI6ZuIlx2D3WrNtu/q410+JxtVBqFx86LtEjP2lIc/RbpiB+jEBTeOhoEyKJ+qWnzwHn2k2OFV4fYT2imGdRxDa4ZsQ6CURT5JV1pWQCZ+TSQ4V/7GV/LBaGtTREEsOOQWnZ9Cjt6TrIjVq2IlwafjQKlVac3gkAVbZhpvIMTOAyj1+sbm766QSrqp/fk0+YhlkzXAAbccBgzRfAO9mkBvTDqHklLgAUJR9PO4EYp043iFN5fhq44TDXbAD54Tq5aTHd/CufzW6eNq4BUfru+dtZMN/dyOJ/SlWGjcIH1rHNGvx8iRMFeblxgFSYQvKh4ThasfnyLcr7/+lMY8O45oCW7LQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(136003)(346002)(376002)(39860400002)(53546011)(66946007)(26005)(6506007)(33656002)(71200400001)(66556008)(6916009)(66476007)(478600001)(76116006)(2616005)(44832011)(91956017)(2906002)(83380400001)(8676002)(66446008)(4326008)(64756008)(8936002)(186003)(86362001)(54906003)(6512007)(6486002)(36756003)(316002)(5660300002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?cQ3kWYoVdFUsj9b2KubMQPoX93N3eRIreHcMxh0HOgCps2eyvwKrQwSCN2Rs?=
 =?us-ascii?Q?VX/JkUCcBjoKqVXScakzkk724d+FYuCPDYt4CIkTuKApp+Am78FUAHSOY44o?=
 =?us-ascii?Q?Ql3TdfBAdPtTmQqeTqVHsu9NCgl8GGorzrEcXoRJO7wA+M3vutmj+sWjf+ur?=
 =?us-ascii?Q?wDWaJkJEkShPXV0qa+6cJguukkRsYRIFyG+HwyoKOHkxI1VZqwCahgZmpmf1?=
 =?us-ascii?Q?oLGDkyB3O2vQA12dq2O4UXO/S3lOUTy9DZ0pMdiSEoUM/hKOvnBCEqbTx5Cv?=
 =?us-ascii?Q?8GVxmqFC/5BDmo+3AK3XZIVgc38oU0N4mNHlMnVuxaVrMEKuYrjlCy4uMhvg?=
 =?us-ascii?Q?OgimHbBS5fYHRwvQpJvySa29QcV3ZpXJ0aYl8ODCRgpwUPGO6ltArrshKpS2?=
 =?us-ascii?Q?HBXwuw5a3yCh+901aPtiQri8sxBIBeDN5JH+7raWNdGqQUTHLOywuO842v/+?=
 =?us-ascii?Q?mSfBWrRIcp2fDFh5zU0o3aAdzHh6BAwT+zVwzOZgh+37KdzHVx3DGIOXJtFM?=
 =?us-ascii?Q?iWPDmdwdeuz/VINaH+7V57q1qO497kvMS4imLAKH931bYvFZqFGJ0tsESUJP?=
 =?us-ascii?Q?FfcUJ9o60jCoNEdg/l/YwuDBwhBG2+Gzgcq8IVUQAsH3tFHuz2+taYxpv4TZ?=
 =?us-ascii?Q?PQ2lIA66WUfGV5EmSdJvlv+Lm5n0JvoPLAaRVVl8/WAgwsfdcrTT0ZSN3B/6?=
 =?us-ascii?Q?C2URf/sMabYw30SQEZTGoVjh2XK52sUPQm9oQ2SoeHou5bvoMFTUI+uuH8TC?=
 =?us-ascii?Q?BMqY8ZP2UHDD+0pxbKoCz3GXQFVwt1crOFLnYjAUzWQdhzANqm9Pvp6obhja?=
 =?us-ascii?Q?YXxcIv9vP/LgGLgCqxhjW9iUnWVQfxWk1m2D5o2LwrqZwOAAeF1jMrV549SN?=
 =?us-ascii?Q?xHutvXmbyJg10Wwje+NPgcZFiWbk26VmrFifC6V6FaRIAnuBsg3uZZo6YsgH?=
 =?us-ascii?Q?h6riposIm7QgFrn5BklzFSIxRID9ahOB9wgYcfQQLbOk0zo/MT9e0SGxtd16?=
 =?us-ascii?Q?VZ217IfTKLgkXHL3YnGnHXjeE8bx+r/AADSVb0rWkzWg9HWkX1pUgHOHWHrT?=
 =?us-ascii?Q?IhQOIHMn5Vrb/3mHOmEAZhQKyhNxbC/CbRBxAgKHT4xiMHT1SjltTc9UdbzH?=
 =?us-ascii?Q?/pc6vERknoSCIYy29jpV7rr/U6qNzrayMYtoRRQHTpCW2ackEA1LN9efgluY?=
 =?us-ascii?Q?OvtwcTctheCJKlrvWfA0NpRZVMIoIoVRVa9Npv3oy/IdANOwGMULP0PhxrQI?=
 =?us-ascii?Q?4VRMvNU5jQ8lua0TX2eJo5L1UbqA6ZEBGOFeiN2jmfQ6Qc0qXvfwc9mNytTd?=
 =?us-ascii?Q?7cVlorwAMJu1Q33YJWE8zJWp?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <EBA2F6ED67453B41A3EEC4ACE39B0ABF@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ca62073-c52a-4023-8fd8-08d8e330c8c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2021 19:23:13.7228
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FiMt9QRVZ5yw4Qo55n4qcPlyb7k6GFfgxHHmO7YRFiFNY5Mho71Th3zYaLCzqzokMQ8oYW3vIOVnTdSsGsdDhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3046
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9918 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 adultscore=0
 phishscore=0 malwarescore=0 mlxscore=0 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103090092
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9918 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 mlxlogscore=999
 adultscore=0 impostorscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 priorityscore=1501 phishscore=0 spamscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103090092
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Mar 9, 2021, at 1:23 PM, Olga Kornievskaia <olga.kornievskaia@gmail.co=
m> wrote:
>=20
> If the server's attempts at sending a callback request fails either due
> to connection or authentication issues, the server needs to set
> NFS4ERR_CB_PATH_DOWN in response to RENEW so that client can recover.
>=20
> Suggested-by: Bruce Fields <bfields@redhat.com>
> Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
> ---
> fs/nfsd/nfs4callback.c | 5 +----
> 1 file changed, 1 insertion(+), 4 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
> index 052be5bf9ef5..f436d2ca5223 100644
> --- a/fs/nfsd/nfs4callback.c
> +++ b/fs/nfsd/nfs4callback.c
> @@ -1186,11 +1186,8 @@ static void nfsd4_cb_done(struct rpc_task *task, v=
oid *calldata)
> 		rpc_restart_call_prepare(task);
> 		return;
> 	case 1:
> -		switch (task->tk_status) {
> -		case -EIO:
> -		case -ETIMEDOUT:
> +		if (task->tk_status)

Can task->tk_status ever be positive here? Wondering if we want
a more explicit check like: (task->tk_status < 0)


> 			nfsd4_mark_cb_down(clp, task->tk_status);
> -		}
> 		break;
> 	default:
> 		BUG();
> --=20
> 2.27.0
>=20

--
Chuck Lever




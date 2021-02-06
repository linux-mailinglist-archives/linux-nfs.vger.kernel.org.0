Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4184A311F40
	for <lists+linux-nfs@lfdr.de>; Sat,  6 Feb 2021 19:00:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbhBFSAJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 6 Feb 2021 13:00:09 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:34654 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230251AbhBFSAD (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 6 Feb 2021 13:00:03 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 116HvExZ137024;
        Sat, 6 Feb 2021 17:59:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=1sQ9JJfLRElxj768TZluzR9APmH8/E8Rw/6ygC7eqXc=;
 b=BgvOqEqSrRwr4JZaAeK8QPJx4LjEcyr40KcHKUeqXnM7VPeRN/N35pDTz3CDn3PCVRa9
 O3VUiEljL9cl9QnpqdGW8F54J5O3IOPdUIQ6xN1evQLodflBv3EhuA/KTcrjFrqEdkgc
 LFKGT/u4woSLgcwILu5zg6UaciKr7YuJ9ZnuuARBcR4Tt1kUK85kZti70E++OnJU7AG+
 z3g2TOBu8fgiDvANvdM/u9aQmCRnyN2G0wSZRcydznO5m5+lh2XkveLKYINjxf6f4y/R
 34J1EnSX+lUySYwnr/WpDqk4UscYGsNodJ1BQgubTI8OTqW8sQQ+KHB/ULk/8T3AiV/o +Q== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 36hkrmrvgq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 06 Feb 2021 17:59:12 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 116HuR1l167596;
        Sat, 6 Feb 2021 17:59:11 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by userp3020.oracle.com with ESMTP id 36hjeh801j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 06 Feb 2021 17:59:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=auhHxsiHUfunYmuZYTyoamEuqLVDl0OkEz+PjWiaBw5nfqW9KB/mFvMM/h53nI5v126YLhoIQwPNzNQ7OsEHOyA/+5yNqeMInILfygx+cCZ/Yo/IQJOYjbz6vNROrAg+wnY9O+vRU7VBqlAI8DbzAAvdYV2UNhlPB2OIGRM9rgPAeboqn5zfcVHB7xSJ856zdjgtxJbGYykGt479LojQhn0Z4vZAtn9EtBoQkvdqFd8+upF6n4k538uxJ0ewwPUxQoUFtMaPLzY8s0H02okSDAXZRwh9HSKELOk34udWI4EsKo0dJoUtQZB2s4JuE2fOUORvODK4xG05crRGU79hYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1sQ9JJfLRElxj768TZluzR9APmH8/E8Rw/6ygC7eqXc=;
 b=YWGOEjaQ98+ZtXQOinKyaNYrGxWGbFXMugoyzhEG6+qXia0iBQVlZD6syhVwMsPAHSq6L9Vi4sJK91fVUHc/SCzDfMIRu3Cbi8MK5lyKYcEjUxHmTkSnP8Rk1WmPzoVaxNI7msd5BX5xvBmfw0eulHrBqRoaqoZpcYANAncuDfKUJKjgFHg1HzpWRQrvj/Ykjp7W1RjvtCnKYVQXUdpL73jRh21H97ZTkCUSe/s6NVI/1cU1T2ZcgPGpl9Dsh0sNPO/wKF4v7s3c9kdSX5dRoMGieegy0CQcPxPUtAjLadSs/X/K3AFAvaqJzzgG90bUuujvKftRpVkvUgaMzKzDDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1sQ9JJfLRElxj768TZluzR9APmH8/E8Rw/6ygC7eqXc=;
 b=l4vw4Z3HjENPx4rZZv6ZD+apV0bypWR7Nrv4jmfEGMZwd2s5mANDp/DARGvrSk6daGDtAFOgeIYhH0JasBaJuafFphtKypvFIEWKeYESu9JKQKb2v1u/hqE18hyMTgZ6ux//sCs9FcZ5ZD0CoZ5yz7NTNA23DkjnlD1Jr4KghB0=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BYAPR10MB3272.namprd10.prod.outlook.com (2603:10b6:a03:157::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.24; Sat, 6 Feb
 2021 17:59:09 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b%4]) with mapi id 15.20.3825.030; Sat, 6 Feb 2021
 17:59:09 +0000
From:   Chuck Lever <chuck.lever@oracle.com>
To:     Bruce Fields <bfields@fieldses.org>
CC:     Neil Brown <neilb@suse.de>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: releasing result pages in svc_xprt_release()
Thread-Topic: releasing result pages in svc_xprt_release()
Thread-Index: AQHW9lp7CEvfS3Emm06zTXNJoADK66o/M5eAgAAGcQCAAy+VgIAACaAAgAGDpoCABhUWgIAADuyAgAFb7QA=
Date:   Sat, 6 Feb 2021 17:59:09 +0000
Message-ID: <4621E2B0-0D07-4AC0-A829-A4CD23E71EF1@oracle.com>
References: <811BE98B-F196-4EC1-899F-6B62F313640C@oracle.com>
 <87im7ffjp0.fsf@notabene.neil.brown.name>
 <597824E7-3942-4F11-958F-A6E247330A9E@oracle.com>
 <878s88fz6s.fsf@notabene.neil.brown.name>
 <700333BB-0928-4772-ADFB-77D92CCE169C@oracle.com>
 <87wnvre5cy.fsf@notabene.neil.brown.name>
 <9FC8FB98-2DD7-4B78-BD72-918F91FA11D9@oracle.com>
 <20210205211351.GC32030@fieldses.org>
In-Reply-To: <20210205211351.GC32030@fieldses.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: fieldses.org; dkim=none (message not signed)
 header.d=none;fieldses.org; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ddf57d57-78dc-46f4-62f7-08d8cac8e768
x-ms-traffictypediagnostic: BYAPR10MB3272:
x-microsoft-antispam-prvs: <BYAPR10MB327213CCD263D8A44C0DD2BA93B19@BYAPR10MB3272.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QrKKIF67qFTKgdJUROnza77xmvIOjI9te2jnzfFUwEnM6BwSx6uf3Cr7ELOt7AsJ12uZo/2vmoaU7e8eRytANIK1dCmt1g5efj/kZcBkAieLzN0tlLJj2ZpJt//kA/2U4Ug439M20ijb777wKrTd+Lggq8xfQI0H20FiX4FY4pMBa4omZ5/aUyI17zu9duV37GMwWHXXdkiKC2wcql2p+T78TVEeOUCdX09a+BHs7jqEm82k2S9VZlhtVpLH66tuZDXt8TArziBmkVEMAOTroIhkrq8niRNr1T2/2gkQULauKUKI/cvu3pjzfLTI6Y/n9FyYFwKMKxgO9A5VzqQp0mI456SNRWh7hUD+pl/gclRs6Kd69l69RRWMbjhHqr8BdHWa6ls8iJ/jD+hPKUpNaeo4Wum2H5pWtIGX9unzHXHxivAIrjKmamY3AvlJdsjXUInmpZ/S9r6XDcbps2sPco1RpgfPq4e9hBzFjyNS2vYogJCETlqFjGVtYCIGQlz7o1aJKZB9G3/+hmXIQa3UZRVlJSkSUAu2DsT3qZ1H90Sk0x9a/Wq6mbJ++rlPs2cAnt2hgKG49UXxB9ful3cDIzyKtd7vtyr7/jBoVZl8My/Z8+bfcTeWXepsNvArMYIO09pVX/n7SV2fm7gPp2de3XhbeuFmd/jJ3RT0T0r7v0M=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(136003)(396003)(346002)(376002)(39860400002)(966005)(8936002)(33656002)(316002)(5660300002)(2616005)(6486002)(4326008)(186003)(66446008)(8676002)(6512007)(53546011)(6916009)(26005)(71200400001)(66556008)(36756003)(64756008)(86362001)(66476007)(6506007)(76116006)(478600001)(44832011)(2906002)(66946007)(54906003)(91956017)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?Rlt+/WS/zw9hw4FuJV76TbOypEwz91oByoAnmqtwqBIGHGAmjK97dc7jLW2X?=
 =?us-ascii?Q?AlzJ5No0Wt0vb4u3RcjA1GV2ICFPskBPk2WDUtPo+Yb3zIFzs/edp/YBGkL1?=
 =?us-ascii?Q?DUKaeCDCr98F/tcG4EKoOwWQyUGkRRa5kInZUpFq7fqfwEjGYkqQv7sSkfgr?=
 =?us-ascii?Q?qyVNbRMQTy+PGKd+dJxlInegufDusJm8HUSEIO43eD6uU55Dx0iTWzn7ZGZo?=
 =?us-ascii?Q?jfajU4+M8XF5/MzHUKJq/o+AOB5oSsLRi4W+OhNQoFWQkwrBBBTiPaDAAVcr?=
 =?us-ascii?Q?hpmaGih45Dipa2gR6gl8JN8ktQ/u9PHxLE1G23a3e6dxwcslXM2NQpL0Y06h?=
 =?us-ascii?Q?Yrsjbel77sU9k3HPWjxUzT+QOMefcCVtKadAWXtxh6Nk2jNko4eRHk8ZBmuC?=
 =?us-ascii?Q?1dMBBgiNOC0lfjfvpcgocsEtZdGILW7jd+q3TiyJxBbl/nt7WHuU1BnLh8X2?=
 =?us-ascii?Q?ZRjbapepk04gmOtOZ61MTW52Xr+u58IvGIkXbf9LEFP/mB3KTuqXJU8tx9hN?=
 =?us-ascii?Q?7nLtpg99g2Kvmom4R3GCe9c0jx6HGhA9oNvyk1B89MuOpyVPqQqzgVK30z6V?=
 =?us-ascii?Q?CpLtEmVdYMLi8ZobELG0sz++xt8vz2vYiai2l/vMR09gqpf5S/BHXlu+J9ly?=
 =?us-ascii?Q?pdcqf7I/kb23/MI2Z8H+FrbtAVavl3YXMJNcTQPLQWUPdTM3ptrsVKO0FvCc?=
 =?us-ascii?Q?EqBJ2QBfkgE3S8csX5WmFBvOBF20cS9Hii8Al29OQ8D2DaXLj1e67+nWzWq8?=
 =?us-ascii?Q?nw94aQPktNoHDlEz/gdtj0wtlkHOy4khyXJJcAXIPFyom8w487F+B3CYPTv1?=
 =?us-ascii?Q?f4hHUcmcLvzKTflkkZwpm/vENwnq6d5wRv6a1anHk9iaTFYTNJ8fTTqkUE+G?=
 =?us-ascii?Q?Sgica/V7P5nYw3vHdRHyn0/BKkdn/c3k/RhjEHsMOeZ2ThX7PQSEZwE40Ddf?=
 =?us-ascii?Q?AJN/tB3uSvcA8bP+8Zw0eoF9spp4I2ie7Q8woeILZiAauQNSLfAAzpGgcr1D?=
 =?us-ascii?Q?jy/XGXB+bLeH2trH/0CYh95Q9ytj/M8h5KfFve10B2yyxAhg3B7nEfIEdGlG?=
 =?us-ascii?Q?rA1E0cz7B1shmJW8VNZ4Nhy/pQR+m+x336Y+AY9YfgaVtu0Zn1Mj5C7PLw6i?=
 =?us-ascii?Q?T3uEPQd219v1zjypxxO4S50YIbjyxG9DaBH2HqTYXe+KeDZf/hy/T4rPSR6k?=
 =?us-ascii?Q?8WXI5jYPTb95iF+1pMMtqNmhzEu2PL5BB252bLEBvs8/U6pQKQ39F6W0vTmV?=
 =?us-ascii?Q?cK26+yVJw7uMtK+3JcEpVbcS9+miGNDp7+A0ab5lul5KnSdqq3iyXGpApOQD?=
 =?us-ascii?Q?RjbjOG1SW655Xjk/ixB1VnEa?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C99965F5386276468EBC5023A7AFF313@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddf57d57-78dc-46f4-62f7-08d8cac8e768
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2021 17:59:09.6418
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kC1K3NI+4eaHYr3Fyw0zX19g4qCTInYGGf5GYaN9X+F+RKcx/gTl57VCVqUuUGuvyTqxKDX+2k8dSQX+5+D5qQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3272
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9887 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 adultscore=0 phishscore=0 bulkscore=0 mlxlogscore=999 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102060130
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9887 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 priorityscore=1501 bulkscore=0 spamscore=0 impostorscore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102060130
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Feb 5, 2021, at 4:13 PM, J. Bruce Fields <bfields@fieldses.org> wrote:
>=20
> On Fri, Feb 05, 2021 at 08:20:28PM +0000, Chuck Lever wrote:
>> Baby steps.
>>=20
>> Because I'm perverse I started with bulk page freeing. In the course
>> of trying to invent a new API, I discovered there already is a batch
>> free_page() function called release_pages().
>>=20
>> It seems to work as advertised for pages that are truly no longer
>> in use (ie RPC/RDMA pages) but not for pages that are still in flight
>> but released (ie TCP pages).
>>=20
>> release_pages() chains the pages in the passed-in array onto a list
>> by their page->lru fields. This seems to be a problem if a page
>> is still in use.
>=20
> I thought I remembered reading an lwn article about bulk page
> allocation.  Looking around now all I can see is
>=20
> 	https://lwn.net/Articles/684616/
> 	https://lwn.net/Articles/711075/
>=20
> and I can't tell if any of that work was ever finished.

Jesper is the engineer at Red Hat I alluded to earlier, and this is
similar to what I discussed with him. I didn't see anything like
alloc_pages_bulk() when sniffing around in v5.11-rc, but my search
was not exhaustive.

I think freeing pages, for NFSD, is complicated by the need to release
pages that are still in use (either by the page cache or by the network
layer). The page freeing logic in RPC/RDMA is freeing pages that are
not in use by anyone, and I have a couple of clear approaches that
eliminate the need for that logic completely.

Therefore, IMO concentrating on making svc_alloc_arg() more efficient
should provide the biggest bang for both socket and RDMA transports.

--
Chuck Lever




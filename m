Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CCAC3C1DAC
	for <lists+linux-nfs@lfdr.de>; Fri,  9 Jul 2021 04:58:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230406AbhGIDBA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 8 Jul 2021 23:01:00 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:41662 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230336AbhGIDBA (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 8 Jul 2021 23:01:00 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1692qThZ010888;
        Fri, 9 Jul 2021 02:58:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=lpaqA32E2mZuDMco2pIeOW2yRM5pWXGoXwd3/tvVQaI=;
 b=IBZdUtfbplakO7sTt6yPeR/ZzfjzqCqfyFpEI6PO6CgnCzt1BrX69SoXJfrXmHthzhDD
 rIHQNq78kWzbQp1OcyYsG8HAc0jaP28cVCYCFCqy/PFMI4waCp4F1VhPbHECP0gU/R9C
 hsQe50R6sZ7bL7Ey7BW60RsLw4fC4hCElV7xigmRzE/S2nGitNyXPKSBKoTBy7LvJfJm
 Tb0emByKA0BxOQ2r3r/zOHGDSIEXTdOZnBcEZzm4O+hfuA/2CuXq/ty59n8A09iW6y2S
 4l7zBaP5oKVcEVHxvgEBVA++7GSRTvh59eXbW1+tp7q3/T7cK8kom9rAmVi63iD4/TUY eA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 39nphgjhpr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Jul 2021 02:58:13 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1692sc86112102;
        Fri, 9 Jul 2021 02:58:12 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
        by aserp3030.oracle.com with ESMTP id 39nbg5xkpm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Jul 2021 02:58:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hBU2eqCAxCZL1gzVYCX1ip6Eer0aE1NwkGgpt1GVrfqq/9yOP3fLhW8F5OpRd1VodC+816mZHLIPPEC2Vlkj1IbOPeM8QRQqsuQc4YSmfMYzeIWtX+s75eeIA1GMEi7xx4VPsY0YSCTw1lRmMBXWNwqh+1+aOWD3r5kMzoBYdTlxvhPiOleQKsamYNWRBYbk705qmR2lU94BlCQUIwjI25zrrEjsGtzBBiiuTzSCLeXk6GLUcCCuO7jdLBg7IaZiSUBUVcqetzSJKEQhtiodC+7YCyiCrvdPqMG1ytPGTQFHHSgMN4h6AuouZSprM0+noYJpn8wYnSS56XK2K9ozKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lpaqA32E2mZuDMco2pIeOW2yRM5pWXGoXwd3/tvVQaI=;
 b=KP+cJSiQlcsvr/CHLQDU/Vqx0pnJW3hzmKz1XEmOhxj3jtGhwpXupkwJRe8NN1JXIPs0xhttFu2tiDjxCNLpPegT5CpPQ+sj039F0YQOaH0GjZyTUAoxwlCn5U4Lp1joJEXX9Pdt4th8hWF0etSCSCqw6+PzvEYFpQxrAFNeXMAAGpK5rY3XHmyJ2RaNjCS4rsVfhe68kAtS74/mJTGi3RIwbEXPeFrt/1hRP/XVQdXeddnifugmWYZjh1a0qXvfQBK2WtD2+bHK+t0hnRIUq41eE29FEWMbggMNNyKNxIeeuerBbPmTSYBuHaCIfbSDuK/buQTJgoJIiklz8yj+yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lpaqA32E2mZuDMco2pIeOW2yRM5pWXGoXwd3/tvVQaI=;
 b=FVw3RX4HyLQK9mHRlR1Jf0Yz6l5hVuh2dTI0A2bse1TThsXtwzKu2tc1M3cqn59xuPAO5YbHWKw1svgpHiAiEx/jpbpx6juxV6Cpu0dbTX2kM6QJf++QydfCa9tSY3q6ybP2aVuS7iK2RYsEAasVntmozjVnre9FnYbKplWQgXs=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BYAPR10MB2870.namprd10.prod.outlook.com (2603:10b6:a03:8d::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.23; Fri, 9 Jul
 2021 02:58:10 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::9dee:998a:9134:5fcb]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::9dee:998a:9134:5fcb%3]) with mapi id 15.20.4308.023; Fri, 9 Jul 2021
 02:58:09 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Neil Brown <neilb@suse.de>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH v3 0/3] Bulk-release pages during NFSD read splice
Thread-Topic: [PATCH v3 0/3] Bulk-release pages during NFSD read splice
Thread-Index: AQHXdA2dfQ0L7epND02Y4GSFtLC88qs5uFIAgAA8EAA=
Date:   Fri, 9 Jul 2021 02:58:09 +0000
Message-ID: <618CC460-3C8E-464A-B6F5-77C9F1DC82EE@oracle.com>
References: <162575623717.2532.8517369487503961860.stgit@klimt.1015granger.net>
 <162578659050.31036.16278478540386858207@noble.neil.brown.name>
In-Reply-To: <162578659050.31036.16278478540386858207@noble.neil.brown.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bbf608a0-d38a-4821-6e32-08d942856263
x-ms-traffictypediagnostic: BYAPR10MB2870:
x-microsoft-antispam-prvs: <BYAPR10MB28708F354FD220E3F34BE07893189@BYAPR10MB2870.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EExq39NlXlZIksK+v3NYCHavLV79xc46jfZf54evfmNiromscPWL/UeTzK3sLYJTqgESJ2HZe4h+H9NCVI30dj+cSwM9ZGvlJpRlngw3bgUvepCqRsI258Vcu/3JLzp/9OY3TLS0qdbaMnRj+cuzmSnRgRx9T9x9RBNZgmQbleuLdElGRjgjCNWP2Hny6VHjGA3OYhIblP4kVGfQfpy+0lNkBRGWPXrMK1smqfQEP2G+3oCjB78iERASJplO5alzk/8G83U8o8mC7a8jpcZORuek1nj7sRAPwZswq8mGDDnXAyxg2TYCmztgCBgcDvVpXrEHqJd8z2XF8uDzyE5ImtqSR8PhGDnMJsqsnSXA3WXvzG+WIeot9cBBb+BF/QRT1lVlP8lJDLUnRsI60PjfIBd1WZ/neELCg6barAeQGa6PfifWZhTnRsUCRvHug8q9AU1qWJfBTZ8bnRU34kFLoIU/49PI5Yhacu/d/cBS5Pr37L6cA0b7wAszupIGklJD+HvPyldTdXIMW9UJ57D0GRKBzxX2xi8RAn5VnlqT5b8XYqPoDl8cFiKZ3er9PQ8xKwPoDPGw6b9ZQZDvizd0nDb/MjBKaATZJvAJMTx/IF6TMZPbBublYXRVf3N2atfadeYwHlMz9ooIWhp2LxE+artKwPVwfOcmWsKglgcjCUmNU2+5l4SZzYPwIAdi0xDHZ7YRwzcxY6g8YyBCngma4Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(136003)(396003)(39860400002)(366004)(346002)(53546011)(6506007)(6512007)(316002)(54906003)(86362001)(36756003)(2906002)(71200400001)(2616005)(33656002)(5660300002)(4326008)(26005)(6916009)(66476007)(66556008)(66446008)(64756008)(186003)(66946007)(122000001)(76116006)(8936002)(83380400001)(91956017)(38100700002)(8676002)(478600001)(6486002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?z+yr39jyP2k63teuUx8F2u4tcQV4qAcUmPamtGCrA8XUiPEjyEjCIMgAZo5Z?=
 =?us-ascii?Q?kBwcx8ERU3tHATHeqv3Qu/fEctLtTrN6kLttKCOnv2YAEyA6AR+kEoNoeui3?=
 =?us-ascii?Q?bN3CCNUVMGQLAMnzvk58BAYmO4/stBcUO+QrBGd/4q2c/EvwlOPOtQtkB9LN?=
 =?us-ascii?Q?gO0sPtuVR5Q0KWgimt3IQF5pjtqRRboTLJQHh0U7LdJDFvIDBVf9GkIQKAnI?=
 =?us-ascii?Q?EgcyJebBQsbnr5iY1t653APSH7nSwRH87JTuibbJfnrado4rxxyExbQnWLxZ?=
 =?us-ascii?Q?jh4IoMAGbafzDlI3m5d+pA20lGUwi9QDIjzHqedZ7b3pXKEbt0g6woQHHYkk?=
 =?us-ascii?Q?qHI0TID6nArOsPCmK5XhLNbOyJuomlrT6wjF62LUt6xn3mQ1jBSZDAmq+reo?=
 =?us-ascii?Q?akxywA+LPHNYMRCkL1dX5BIac61AMgWPWLh+grYwRpBJIpt1T4rs5lKQWZy/?=
 =?us-ascii?Q?ZGSGeyb2YA3UsmmFoVVaA8RXPlqzvrFxFYyUkgd9wMuxQ4oVz9TrOZjboybR?=
 =?us-ascii?Q?BK7Lcd68+63RFHpL8PpcHxuu0bcY5ZK/nWUzfDmhZaWzdqbDsaWMOWqvzbB9?=
 =?us-ascii?Q?bqX2Y9Xaa/jwcf5Vr10kWx6AiEI2/+ol5ZslY/LAWlik0v0s0XkAJnJevrTS?=
 =?us-ascii?Q?rYtmZp9pOyW7rLDAqZyV5biV59iLXUVxlh+nePUOs1LBugOXB/IsUSTb+FpW?=
 =?us-ascii?Q?nhXLy8FiC3ltY+GN5W8FpC4sF/8y/6GOAib+yUDhSTZmytpZp2s9v9r0wi06?=
 =?us-ascii?Q?mXrXmIIWZaOlHebkdF7QE9tzUN1NoyvfDl+cdePMBMoT4PcxjLZSQ0aQgjpY?=
 =?us-ascii?Q?J1AIc1EetygHY4LZJ9teNXstA0fUf4TV13hgcgkCQyMzBF4m6MqQfppLTDHy?=
 =?us-ascii?Q?c/7ANuri9Mb1OEBKnq7duFuNB4LgR5VrUG3K+oHJpEh6FpcsAAOa0tn2fzr5?=
 =?us-ascii?Q?RxM7DWDbEchjePMhTVXsKjN/QACh0V7mbqcvjaaDARhbpihoNOcz4G3OT4Ke?=
 =?us-ascii?Q?kBXG4M5EjUf2fpGqeDtdYIz267GGEMihl7RuoOAA/ilDJXQzDhBuwYOTw5R4?=
 =?us-ascii?Q?H3gogAa6f7ho9Hst4Rzi5T0S5f5PK6sFzaXQ9kNGNUQkmaszTf46cM837kvu?=
 =?us-ascii?Q?gAmaMSJm0DXX58uJpRpMC+caMnn/H71ie8SZnWiUiKS6898F4bIIfRQtyqYR?=
 =?us-ascii?Q?kQ1eJmiTEAdHBdL4lYOx4B6f6WduGUG6geYpkUB4zbqJHw2+PlSIkYD/9h0M?=
 =?us-ascii?Q?eRE5XquktTNSDHMkZr7FrVFmq+PjCQmYy/DJfmLTQqoKDBCzCALQaVGjFYNy?=
 =?us-ascii?Q?ss27vcds+Csqeutma2DhYdLB?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <CE2F3FFB157CCD4691D772731541EC37@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbf608a0-d38a-4821-6e32-08d942856263
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2021 02:58:09.7586
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5r0R07DEYz6CCSJ2I+kDqfZ/+ipNhimzwhFCaIsgsmbYd4JupoLU/4tbzIxWqcxUJ1jx9vrB7EjVq0JOBv7wPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2870
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10039 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 phishscore=0 adultscore=0 suspectscore=0 spamscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107090011
X-Proofpoint-GUID: uZjybirfwqyUG-o8a0QmBMXp0SCUPF2v
X-Proofpoint-ORIG-GUID: uZjybirfwqyUG-o8a0QmBMXp0SCUPF2v
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jul 8, 2021, at 7:23 PM, NeilBrown <neilb@suse.de> wrote:
>=20
> On Fri, 09 Jul 2021, Chuck Lever wrote:
>>=20
>> In this version of the series, each nfsd thread never accrues more
>> than 16 pages. We can easily make that larger or smaller, but 16
>> already reduces the rate of put_pages() calls to a minute fraction
>> of what it was, and does not consume much additional space in struct
>> svc_rqst.
>>=20
>> Comments welcome!
>=20
> Very nice.  Does "1/16" really count as "minute"? Or did I miss
> something and it is actually a smaller fraction?

6% is better than an order of magnitude fewer calls. I can drop
the "minute".


> Either way: excellent work.
>=20
> Reviewed-by: NeilBrown <neilb@suse.de>

Thanks!


> NeilBrown
>=20
>>=20
>> ---
>>=20
>> Chuck Lever (3):
>>      NFSD: Clean up splice actor
>>      SUNRPC: Add svc_rqst_replace_page() API
>>      NFSD: Batch release pages during splice read
>>=20
>>=20
>> fs/nfsd/vfs.c              | 20 +++++---------------
>> include/linux/sunrpc/svc.h |  5 +++++
>> net/sunrpc/svc.c           | 29 +++++++++++++++++++++++++++++
>> 3 files changed, 39 insertions(+), 15 deletions(-)
>>=20
>> --
>> Chuck Lever
>>=20
>>=20

--
Chuck Lever




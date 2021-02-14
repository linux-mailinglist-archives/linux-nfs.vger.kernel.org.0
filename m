Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D495431B15C
	for <lists+linux-nfs@lfdr.de>; Sun, 14 Feb 2021 18:01:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbhBNQ76 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 14 Feb 2021 11:59:58 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:56706 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbhBNQ7z (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 14 Feb 2021 11:59:55 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11EGx5h5030189;
        Sun, 14 Feb 2021 16:59:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=pQnjoQ4cuSs33A015/NPDL1xqbrTvGTLz1sCIKjg9yo=;
 b=e39x0nEg9xtk6BQmdZDoYlnnTsrZ2Q+Ut4W+tT8q3KcISox98p/yB4NglqoOALTmlgix
 oJk/LfKCiMnVeplEEgEJpIvfjw0qpsuFWpKNc4/yNDURvQJOtItEDxS6fuB/PyFsSmQ3
 GD7NmQ6vyCuJOB+ZNFm63ePfdgt4GW5rCYazvi9b/45q48bGNcks3mZkvCKFchNIj4Br
 UzT5hG+Eg/NjbmfFRxkcWJ/w/qZ+OKuEO6BB1u4KDpeUi8dtJJBxMc3gnwpXgNRBx73s
 mthUN6AK8tsneejkXLBjjR9SwR0HJmzQBsadT5ce/YbJIqnWIZKt4vE3gdrmrJiIX1/u OQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 36pd9a1qkx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 14 Feb 2021 16:59:05 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11EGtx9K190321;
        Sun, 14 Feb 2021 16:59:04 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2106.outbound.protection.outlook.com [104.47.70.106])
        by aserp3020.oracle.com with ESMTP id 36prnw08t5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 14 Feb 2021 16:59:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vui/LSr8SXUNCqxGpvdeeHMCYITbZg0domj6B28RHr5//qJTapYAv0NHJ38o2wZbs4iMlkquqVllXX1GJacyMttl1rAGbkKCWLZpkxkRZ8Tx5XKN4UYlbWrLmrqPuqSyZQE+A7YHUw92rxA7DdwwJcFwhmwPMFzLys1cs2NH7AV+ErjaVepenxdG5Idxf8XgJmjBI4tmElBpNL5nFCvUiu5H63eF+afx9NY9roTjk9ZCaLTJsMuIO3Gu5K3GmlQMKguHq2PDsOxsTF19AbVRHjrS4hn+TASO3kJdU23P4m07FITEBNfUpShoJAfdIfdrsRhsXbeFb++5BImTxTLjUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pQnjoQ4cuSs33A015/NPDL1xqbrTvGTLz1sCIKjg9yo=;
 b=Jw8+n6+j3+Z+YgWMLOKAYPvNEoLACI7BAKtA70ju8imO9DesSBWuqWmjDyXmoKhSImDpWsgq8klbHPBgxBVJBHNhHclukV9VaF611CZnkvmrU9SRAi20ngPHJvOiycmSyi/VBMsRW94Q2QF7FgyKjJU7hLkD6Wt9uXBl8wZlP8fnkvdwvNM6MxJlK7FlhIwhXmNtR4J8cTbm9Li6+d9vWfdRez+zlqKgGn0INXpBG0RrKOW+fE1PruI8T214BoFiW1ZYkF8mbscN/YmvYA8nB1UoRi4e6a6v9HkVhEGbebJIWdGDEAqleuZLVC2lcrOKr6ACDsaMijAHQpUKt0X7GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pQnjoQ4cuSs33A015/NPDL1xqbrTvGTLz1sCIKjg9yo=;
 b=Yean6XzoBYGrM6KseZ4cFPnjTsrIGZeeaPEZfF5KFDC1N+ao1ZPpOwnjG4kIiu7ksgcu2lM9NqIdZtsn60HCQygHQohNjNzXW3SnkFfYHIHN+IxzTKJb+HxxWCJWpX0/XcmMVxD0MvnmtAnRCXr/BdqB38LyhExF2jphOj+ZZV0=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by SJ0PR10MB4814.namprd10.prod.outlook.com (2603:10b6:a03:2d5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.27; Sun, 14 Feb
 2021 16:59:02 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b%4]) with mapi id 15.20.3846.038; Sun, 14 Feb 2021
 16:59:01 +0000
From:   Chuck Lever <chuck.lever@oracle.com>
To:     Daire Byrne <daire@dneg.com>
CC:     Trond Myklebust <trondmy@hammerspace.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Bruce Fields <bfields@redhat.com>
Subject: Re: [PATCH] SUNRPC: Use TCP_CORK to optimise send performance on the
 server
Thread-Topic: [PATCH] SUNRPC: Use TCP_CORK to optimise send performance on the
 server
Thread-Index: AQHXAkZmunoZe40LXUmxO15yQAmlIKpWoMoAgAAEs4CAABZCgMgY7/PBt+g1IgA=
Date:   Sun, 14 Feb 2021 16:59:01 +0000
Message-ID: <E39E6630-91A9-48DA-A6CF-6AE5BF6CEDD1@oracle.com>
References: <20210213202532.23146-1-trondmy@kernel.org>
 <952C605B-C072-4C6B-B9C0-88C25A3B891E@oracle.com>
 <f025fa709f923255b9cb8e76a9b5ad4cca9355c4.camel@hammerspace.com>
 <4CD2739A-D39B-48C9-BCCF-A9DF1047D507@oracle.com>
 <285652682.9476664.1613312016960.JavaMail.zimbra@dneg.com>
In-Reply-To: <285652682.9476664.1613312016960.JavaMail.zimbra@dneg.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dneg.com; dkim=none (message not signed)
 header.d=none;dneg.com; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c755185b-5c5d-424a-5128-08d8d109d43c
x-ms-traffictypediagnostic: SJ0PR10MB4814:
x-microsoft-antispam-prvs: <SJ0PR10MB4814DAFF2F41F90CF401CB3093899@SJ0PR10MB4814.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: I2x5zRPuPdnlST9561QixvLufcb6mJYXlp3TYV9EnmAgf+cRHCZJC4u7ggQycRVLKNEC4IipGPH/E3qMWCqYH7nTu9AP1meuMsrdFIgsPNBREdFiUmyZLsucHBsgXUQnvK+aYiRU8H/+UwOjEY8cA20ZezFxKa7jJDZpAEUep+25+ATfeYG3AEMx9sj7sTNHAP+Z8ee6vo3SmRbM9pmdxsRhF+7aLKji+IZ5UK5lQY5CgZgg185yAEJbXdFcS2R67iueIpnyzrmGKFHABFGX6pR65zj6jaMfqILK9QprVDLWJqKjjlhWYggcy9ovBOkjsWi0lkdcWgRF2Mc1P+SH9jsowpzXqRysOKXyr8bKeevtBW9s+1kBcgirZuoX9GdhrpwfBlWup/6MaJdQzxRUv6nUftJdVTe1EynDvSYsHL5V2q1mecBaqgPBTJZGNHK00E2YVBvs36DdIdVNBtH2Pq9e523obULBGmHSpjQ6MrGE52KX5TxzTyqOYu2Ya521UjKZ3Qalkq2rLpWXKVMJtMF7txrg6bWsH5nGGUqiuN9mbUSglEtTr8ZFGSW9fKWC1xRZXdfr6O9u+qxInJx1YQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(366004)(39860400002)(396003)(376002)(136003)(33656002)(6506007)(8936002)(53546011)(86362001)(4744005)(6486002)(316002)(5660300002)(6512007)(66556008)(2906002)(2616005)(66946007)(478600001)(66446008)(8676002)(36756003)(4326008)(66476007)(26005)(44832011)(6916009)(54906003)(186003)(76116006)(64756008)(71200400001)(91956017)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?PP8AgQvPGUaohBnVsBxECIXf0gEEZDc/8fdYSEETY5wZOQ/HmX6bBrVUY/1g?=
 =?us-ascii?Q?jc3cOU76QEpCHbRq0UfqqmE2v7Dc9Nwm41uBKDGpBsBOD5rc0hX62OsHi6/W?=
 =?us-ascii?Q?fy1ryo/Zdl5F7zW5U37gFNjeOij7ih1TFe3ALl2305Dz3N1K+CrvSaJv4xhQ?=
 =?us-ascii?Q?PLh4NFZOrnu0xCJUPNFPrctlV6Efnpp/azsK3ZeACpjbMxL/nGLpE9BFD407?=
 =?us-ascii?Q?4Awsmb/ZuJU0NBdPDNRmtDNBaZnyUtzx87JwtkKbAZCcBHqoQtWsRq29X+xT?=
 =?us-ascii?Q?IMw70LXULNTpqyCCcgl1rWctu8MJ9L/iNjXG99ENVV3goRbIUKwNLXpu13yN?=
 =?us-ascii?Q?IaqKkcekD3grucQ2tg0nhMWU6AhJlS7GzZPNMi9z+ILbVQrHarJNsDkOgxZI?=
 =?us-ascii?Q?mQ7VqjF+86A4TL5lPLy/AzoaZw/OfWILsBik0TWGVZamqHsSaKFfGUBwCWqZ?=
 =?us-ascii?Q?CTt+sLJClwg1Eol3t5fG5D3LU3GO4DN4BEQ4FwUdGLnyukHk9FeyB78Ug5PT?=
 =?us-ascii?Q?vDmYzn1C6vLhUol5TELnpHD/jfb0Mtmxqtaim+qEIUy+rD2TT6TmqWwy0IAn?=
 =?us-ascii?Q?khLAsdyiDuc08lkqh35VD3gNqpYN3qzx0rJhjQXayX/6pwKqWEWflD3ksE/E?=
 =?us-ascii?Q?woKR9FgKSfXWj2XFgvWHAqpFDcavi1p/niBFp9grHrPdgkRl1YQVa5EawD4L?=
 =?us-ascii?Q?quWM0AbZ+7RZr/wR4+l0oPS0iWNzb5Faa0XaMlVf36G7aiMOD9FjSKIEoAV6?=
 =?us-ascii?Q?mdqV1ZhzNFlrluc2SsQVVWpWL69fqUTSkU5ngsIeCUtLRaRSQ5gJNPxHrOL7?=
 =?us-ascii?Q?FoPWR+yjUUF+Nf8ksUVyNi6/1UREt2PrzJI+aXTxstxU7gc0DQ/PztgwOj8g?=
 =?us-ascii?Q?MPzPFOBfyXHMfNds9RwamCwrA3qME9C3asx1SLDqp7mCuqRKxtCLbjaUss8f?=
 =?us-ascii?Q?pM1aHtX5/tNLLHJUlATWfG8tKXlM4Kq+g/OGLOpYjMkQONxRHymbWstJ2rE5?=
 =?us-ascii?Q?T1K5JDvuh0+9r2Nb0XF8hm9OEKSYKA2uaJZ16UuH24XY1BmmrbyvrmR0uV4L?=
 =?us-ascii?Q?N23fQGSCKAbVl5pfWzi7W9W6FyAC7TuE4kQaN0MONC3eXdgDCfDeCMDrYGst?=
 =?us-ascii?Q?VdYzjPYQJGR6PhXgmIUlYK+IleDGUyiF8DY5Th+y+QkQhSM6OXt2IqZNJ8z4?=
 =?us-ascii?Q?viCJ0+FVGF4oBqchBkYCuRNw96oq7thzs70RbNXuTm76MwYKdv/3YpGa4+3B?=
 =?us-ascii?Q?0X5GFlRwOTKQoWuMN3fy1UIAlkaj/cUccv+nkKzeBKVhSrHlQpohVm6pDIOg?=
 =?us-ascii?Q?UjxpJAYpal45DkxXI3QIPEvk?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3197FA1509371247BBBB1508CAADEFD5@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c755185b-5c5d-424a-5128-08d8d109d43c
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2021 16:59:01.6915
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hlzwkMIBjtDbyY8cePUh4vvDW2brIST4qiv8jI+neqpglNx04Bo1PilSiFiCmv7zKreC3HUrYHqqjg7Upee+mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4814
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9895 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 bulkscore=0 suspectscore=0 spamscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102140145
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9895 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1011 impostorscore=0
 mlxscore=0 phishscore=0 mlxlogscore=999 spamscore=0 bulkscore=0
 priorityscore=1501 malwarescore=0 suspectscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102140145
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Feb 14, 2021, at 9:13 AM, Daire Byrne <daire@dneg.com> wrote:
>=20
>=20
> ----- On 13 Feb, 2021, at 23:30, Chuck Lever chuck.lever@oracle.com wrote=
:
>=20
>>> I don't have a performance system to measure the improvement
>>> accurately.
>>=20
>> Then let's have Daire try it out, if possible.
>=20
> I'm happy to test it out on one of our 2 x 40G NFS servers with 100 x 1G =
clients (but it's trickier to patch the clients too atm).

Yes, that's exactly what we need. Thank you!


> Just so I'm clear, this is in addition to Chuck's "Handle TCP socket send=
s with kernel_sendpage() again" patch from bz #209439 (which I think is now=
 in 5.11 rc)? Or you want to see what this patch looks like on it's own wit=
hout that (e.g. v5.10)?

Please include the "Handle TCP socket sends with kernel_sendpage() again" f=
ix.
Or, you can pull a recent stable kernel, I think that fix is already in the=
re.

--
Chuck Lever




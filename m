Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E8E0414EE6
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Sep 2021 19:18:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236706AbhIVRUI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 22 Sep 2021 13:20:08 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:14710 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236701AbhIVRUH (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 22 Sep 2021 13:20:07 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18MGG0ax027967;
        Wed, 22 Sep 2021 17:18:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=nJpcYXR1+VnalfgDNz8nrkrRrWT3PFMT9r3oe7W620A=;
 b=fTOHmndr2mOjSJp8mC3InKOgZicYCxzQRl9DtyVzwaP9OJXkusvPgBfMlA26nT2S6KOt
 2Lg8W4QWI9h1rx+fqm/6Ii4R3SwDZDioaGZKq/cVzFEMa1tfMvsFIK1Ukt9nRh3tTvaG
 jsLI+rSs3tuvOVyVxIDKVNTVJtpo3F6mPAjVUwbOSQYosijVUUHogpnXBqpo47g8ZWFD
 nKLv/1dgCJHyFLOYiCWogfFk7S6VAnKrXbnX6m4Ce5vFZ/jsRLC5vXOYgjM1WJ8PY1LE
 ZhsTGmMp6xjEirUvT38hflIBEMCiF5/q0rGXY6eTFOpQ0BKSJA+Ts0QkoPOaYAhc2f1C Bw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3b7q4rdq3j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Sep 2021 17:18:34 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18MH0qoV168684;
        Wed, 22 Sep 2021 17:18:18 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
        by aserp3020.oracle.com with ESMTP id 3b7q5b0dac-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Sep 2021 17:18:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rf5iXqJoD9+AGQSg6cIaKjYXnsw2XHG6ybOB5+T8hJLHQzQ9fDW1ARfKcJSj+mkuCyPdC8g0k4fbGL0l2y4qfVvFDCo4FNGFsW+ncmeQuGf2/L1KR8Vsx9o1eBJ9/zuAsgoddFzVfVWFO8EuKKKri8Be/w0WYNam+BkqCQT7npXGOzkINHUERRvHvyGuC/pQPqVBxVNcnP8UAxEXLnSm7GmCuQ4FfU2BZZBp31hBdylioxgMXgLrdD+BlBy7pgFRDCz2knL8L7cGR6Xjvyjuh5Yg5yZuaZwz07Seys8VRHnG2qTJaTsMOrBpqQlQTTHTx0s499hW7ShPbSn24BRPsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=nJpcYXR1+VnalfgDNz8nrkrRrWT3PFMT9r3oe7W620A=;
 b=CsmAz0jO7osI8sYYDVfzZEPbZsHPMFMQqlJWGANnsIs8jM0R9WW9s0g6ep63IfqXCq+74FHeyUiI9CnIkqiLqNaiIVMvSyGhhNzfU+vMK5aZN+0QpObLcYyR4GdRKy/G7DH7v08QK28tR8QIHTPvZHNJiUeZPQDd4/Bn3+Mb1M2RCKqsMTyTR5Co5sI+OlGI+Tq2pUFsZL69W3bWDm2UTuX7iTtkCnRxowfwjP5dh9V10DbRKKCwWDv9pVmWCRy/3DaFe7OK49qI4MBiqmU67mAL00cavqNP9XUCZ0SdOpHXQ7n+2kYw48R2UCFk4YqnHByVeVRenMylkfhun3v7aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nJpcYXR1+VnalfgDNz8nrkrRrWT3PFMT9r3oe7W620A=;
 b=af6xMW3P7Z/QwVjyodaB9VJirWaXq2Ie/CQqw3SJrNHC8WyF8LWhs7zjZveiKTjoR8lTsjcoQO+xtiq5YYwk7UgkJf7z58mOD84t/7K1rDiQfO65RUBpd/Jk3qWsUN8lW1Ue6b/f3ZWE/c0QWeFKy1uPuI5ZKUAAtigHVB7KI7o=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BYAPR10MB3415.namprd10.prod.outlook.com (2603:10b6:a03:15a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Wed, 22 Sep
 2021 17:18:17 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::f4fe:5b4:6bd9:4c5b]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::f4fe:5b4:6bd9:4c5b%5]) with mapi id 15.20.4544.013; Wed, 22 Sep 2021
 17:18:16 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Tom Talpey <tom@talpey.com>
CC:     Olga Kornievskaia <kolga@netapp.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v2] xprtrdma: Provide a buffer to pad Write chunks of
 unaligned length
Thread-Topic: [PATCH v2] xprtrdma: Provide a buffer to pad Write chunks of
 unaligned length
Thread-Index: AQHXrKoH6xzONa4SrUyyn/8X0ldtpKuuumkAgAAGfgCAAZCugIAAAMAA
Date:   Wed, 22 Sep 2021 17:18:16 +0000
Message-ID: <5CE77E8E-97D1-4FFE-89AF-7536C3ABC6F0@oracle.com>
References: <163198229142.4159.3151965308454175921.stgit@morisot.1015granger.net>
 <d69234ec-4688-e5d1-17c3-247841d47d16@talpey.com>
 <BAFA239A-2F60-4163-AB20-046AFE6B6F7D@oracle.com>
 <04ec7294-f456-65cb-c401-5a56f61c8dc7@talpey.com>
In-Reply-To: <04ec7294-f456-65cb-c401-5a56f61c8dc7@talpey.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: talpey.com; dkim=none (message not signed)
 header.d=none;talpey.com; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 45e0af66-03a3-4cd8-8caa-08d97decf7a0
x-ms-traffictypediagnostic: BYAPR10MB3415:
x-microsoft-antispam-prvs: <BYAPR10MB3415199309D94D730346825A93A29@BYAPR10MB3415.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: V9NEf/VVBWPT327MNzMT188jrz+A6UT4Iyb4aHlqzWbtMlP8yayMjlUuWmse6xRa+NaUXdfw6hC1Ux1xIe+mTOAngStO2TVkXJXsWyUcD9faI1WzjMjnqYk6iKMqdd0x+AvaNxF1QlKOJNnZ/Lt53OGfXmpXSICpTcOdH7a54XabAPxvfart6+92n8ZEuhi4S34zZ1tC+FYr55gHZKL5wqn0r4gWWHSH380Ip2qp7iEa5AA8Y2Ep81lLczWI4wp8OIBUd3gUNEwsUMVsA6jUCWH+T6rIlGtZGC6CvNuGGQS36HF8lXppF3mqpPeaurWtyVhXLs2oiWpC0hihkFl3fyIiHTg31GvAk98/ElPGuYnt6BoHJWYBDzPKQ8ZJOlCcQ5bE4efOQWuEmvSghiLkpXotitsU/41N7gxCgGCnZHHRuMTtQPcyTmVS2QIOcN8mcxDjmMK1PY2UcxDmbF8gsfHAXdRMaoeodE3YxRqUY5P8wF7nPGk9yeijoYvLB/hgmkp/W0d5d5426t7tBC9hR+6p+Z6L2YabKH5qMr7vuZO1hsJ2RMEAYtKXKeg+440jVeHL18kRxxJ0fh3BaWhvo/2HwYwzmtYUN+AIKskjRMrhNLk31INh4U5L9X05KXjwNm2XRK/BgZPbSB22ydyZW2zgRxPgtAQc5QZvmrm9DmvJKJ3qqwiCyunR790p4b8DRMypVmqOiOAsDZzHuVkJzj/0CfKgp+yGWau7TgNp59rZFySGdhLth5dIMubbr5yj
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(71200400001)(508600001)(33656002)(26005)(6916009)(53546011)(5660300002)(4326008)(76116006)(54906003)(6486002)(316002)(122000001)(186003)(66446008)(64756008)(38070700005)(2616005)(66946007)(2906002)(6512007)(8936002)(36756003)(86362001)(83380400001)(8676002)(91956017)(66476007)(66556008)(38100700002)(6506007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0Gbn7EyuSS3ZfLsMwFV1A8StJWmAntW0ikDCLDBHmfyrCFAuoLkujR7S4SuJ?=
 =?us-ascii?Q?pE56gXqVgV1GSRNNOFrIdT5D3z6cFHK5xyVuS11QtO7sp9w4h50DEccPXn/A?=
 =?us-ascii?Q?QXBt0iIJZmCqm4I8Ox5v8rNBSSktjJ45SLUBQ9f66ebz6P0TDegl+kw4UDam?=
 =?us-ascii?Q?bUCdO95Pu4LpWB9VoZ2BBpd8mnTtOXZwrEmE1+gCr2JrS7w0mbL3EdDmJ2m2?=
 =?us-ascii?Q?9MLRsg05c8zrF6An0qBBYiQlcyFp/Lioz25bEzukAzuIhicP1Q0soSL1KLmI?=
 =?us-ascii?Q?6VsZc9BRcWz4rhezQLHi700zNPT9wcVmcPzgf+gP7uRJP/ungR0DBDO2avE5?=
 =?us-ascii?Q?5di06c6vH3KXWrsVKZfNIVc5eGm6fx8voT+zWRWz63+uSp3/9wYKD6+HkKtL?=
 =?us-ascii?Q?Z3eMKwdNekxnl8L9s1Hq79hI2v/bA7zgpzHa5D4wEH8LOgtl5YR17wtIZtTh?=
 =?us-ascii?Q?WW7zlGYccFlzvrwz4dY1+VFV37TCqL+4DpCfo0KtATb+QAsjQLkJRmsjqZtM?=
 =?us-ascii?Q?l1xLBNX7WKkthkkbnCSIpnLGO7K56qfUAN5RhqlPFrjjQ5rNp0TKcC56z52I?=
 =?us-ascii?Q?VDf+LzMamFYgNN3WwLkRI4Xce6oPJ2RVvsc3g+9JHUyIZZmSfWckp8nFK3RL?=
 =?us-ascii?Q?uNqbN2oGfoZVWTLV78YtRo5o+Ez9XLqck2nMO7D0POtqnvbooNFWZ+Amyqnf?=
 =?us-ascii?Q?hadWGEJA/2k2sboT/ecdDHmIeDXgPqXRloXlbScZxfqzQSj1wf7zkKdxz4QJ?=
 =?us-ascii?Q?69UNEyx3628duy/zXX4B8v7vJrsgXC0RrS8QPbJxuakXOSbcj0X3wAgu65/f?=
 =?us-ascii?Q?ir2EP0NG74BgZdjV4LnY+delcA1aZ8ekQMnPpbUEg6nD+X4HFHu7dMbPJ5Sw?=
 =?us-ascii?Q?YHtLPKGCjszDCamsL0yyAGF0zp+Pew8QSL0Of15K7+/gZdTpBkgq4CCss8cD?=
 =?us-ascii?Q?wT/iLjrx0xuvysH/xqDZzR6ViWXp1AWbHNYMRPFXFHe0u4tYEv/Pfe2Yn0OT?=
 =?us-ascii?Q?s+3JGAvvT6eNHZHblwcI91YMuys8sGwIUnnI0fj4e//1lkCX0Rs9pqb9d4aN?=
 =?us-ascii?Q?0Lnd2lprb1wOCrS3RtWIMGuwHebDtJ6NU0PTuzWKkz11mYnsJU+DGDx7kzyE?=
 =?us-ascii?Q?4DyI2xw7EpsZ/uLzS+vbXDLKTl8eRL8ESwz2HJuOJqNHns/9Not7fAUdeKgH?=
 =?us-ascii?Q?Cshs504xOXkUz/z+wAnvde3jxMq2CJR04IqKeG2j5ydd9aSoSTjAe/+GUDD6?=
 =?us-ascii?Q?LXfRei1TbDaWuSN4X02DN1aznNuL+YmWn9xVlTDqk55QzljAmBYtAoAqHknP?=
 =?us-ascii?Q?uuFlJ6yvL7knxxOr8Et6yR6C?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C235DB371A2DFE42AC6CAE699897C5E3@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45e0af66-03a3-4cd8-8caa-08d97decf7a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2021 17:18:16.8918
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JE0IQGCHQ/bkv0IhFYo6g2KqcWTB/aI37LEJphGke0h2DLkSbjC4XywdaPWCA0Zqi7nDWgZ4buUD6hzqewiA+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3415
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10115 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0
 suspectscore=0 phishscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109200000 definitions=main-2109220114
X-Proofpoint-GUID: aoP4DkS0ohFfw1hj6zPutecYAoinFZQR
X-Proofpoint-ORIG-GUID: aoP4DkS0ohFfw1hj6zPutecYAoinFZQR
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


> On Sep 22, 2021, at 1:15 PM, Tom Talpey <tom@talpey.com> wrote:
>=20
> On 9/21/2021 1:21 PM, Chuck Lever III wrote:
>>> On Sep 21, 2021, at 12:58 PM, Tom Talpey <tom@talpey.com> wrote:
>>>=20
>>> On 9/18/2021 12:26 PM, Chuck Lever wrote:
>>>> This is a buffer to be left persistently registered while a
>>>> connection is up. Connection tear-down will automatically DMA-unmap,
>>>> invalidate, and dereg the MR. A persistently registered buffer has
>>>> no-cost to provide, and it can never be elided into the RDMA segment
>>>> that backs the data payload.
>>>=20
>>> I'm confused by this last sentence. Why is "no-cost" important?
>> Today, the client turns off this XDR pad when it can because it
>> is registered and invalidated for every Write chunk with non-
>> aligned length. That adds a cost to providing it.
>> No-cost means we don't need to worry about optimizing it away;
>> it can be provided all the time, if we like, because there's no
>> additional per-RPC registration/invalidation cost.
>=20
> Sure, I get that, but it's not actually zero. The MR is allocated and
> therefore consumes a handle. It's a way-better approach than registering =
a few bytes for each rpc of course. I guess I'm simply suggesting to delete=
 the sentence. The other sentences cover the issue without the possible con=
fusion.

There is a bug now where SG_GAPS support is coalescing the Write
pad MR into the data payload, and for various reasons, that's
not safe to do all the time.

So this patch addresses that, and this sentence calls out that
specific part of the fix.


--
Chuck Lever




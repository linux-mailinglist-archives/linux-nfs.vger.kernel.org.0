Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E162A4402D9
	for <lists+linux-nfs@lfdr.de>; Fri, 29 Oct 2021 21:06:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230221AbhJ2TIw (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 29 Oct 2021 15:08:52 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:46418 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230168AbhJ2TIv (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 29 Oct 2021 15:08:51 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19TIluw3020570;
        Fri, 29 Oct 2021 19:06:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=CIwKmAQCoPfl2sHx6B3MygAhsR8YxySW6PMJd1KUz3o=;
 b=LHfW28dGfN0RnckkTUIT/Na9f1XkYD07mNcnjEsO1N6FSqq/eSlY5yWN6/uf95r2d9qx
 QcT+eoFR4+V5VG/7asVNlfdvcTsM4W2TWH1rlunajDx+bcSudvmTkYxj7LraSNxPBpng
 b/SSzA+VZJVv0SHsWr3bOO89SRvk7LdoQW6cQrEIhKOh77DNGHF7dY3pypdmkjM5Kf/M
 jPWId3+hgyk0sNQEwmpxNgEHXO9pS8J/kCSDHFEoxTtN/Pi+on9OpTdRaiL8pJqOWmPz
 fWv1gj2T+esexx6iKrvoVm6/luC5cHmRcWINuWBaM9SJlvFFGRDv8AA6q69dwDfgVhs0 2A== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3byjkf9un1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Oct 2021 19:06:12 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 19TJ09Wj034060;
        Fri, 29 Oct 2021 19:06:11 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174])
        by userp3020.oracle.com with ESMTP id 3bx4guy3mh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Oct 2021 19:06:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UQoCXuHI3MN72APexN7oy0OiaHF1b9m7qouaVrrvGeapNO1EveLDerY+udX30MEqSwTly2E5+MF4+mTrhoKUATwkVA6yb5QDwxnqFLye++mbCZ5IzuVolJ3kqlRfbjs3V/z/rMyISRkr7+2NnDbtbDpq6WfS12U4wa1cTu0OFef39wKHhu9h1fB4vg5/7lHULsuyNPboNI2tFgb2y3bhkMBIU3/JdSxb0CidxiS3UcJWft47SvcXmmpFVN9oaN2o9lDEqJCGDzMXbiR2GANLxEyVSiughq8yBGbiC0rB6aiM/cGMg9LIS1cD2tmSWnSTIAtqDDLuMNZceYSrEsIb8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CIwKmAQCoPfl2sHx6B3MygAhsR8YxySW6PMJd1KUz3o=;
 b=GsRjsX3HCIpiod5ye65yf2ADwsKgT2tuHzrartE729GTQ5Wf6AAbCaXzGSKUsEJ8l/9IdMu27jStZKIONVbgFdZvMw4jzqzykD7oaxBqDFYK42V+rVPHku0aqC/dYnL+QcCrAXsmToSrgLQhQIbU0UswRK5uKRQ1512ojZqWaKJ3IeVih4MwAMNQJuHEz3y/q4YM8iNMLmvfJiALM5SxY83llyPUxwRLIC7/b628x80O7lAZba3XV36MJOEgA1JAWdGGp2gkXH3UgkF5jGR2k64AreblNRZHCNCdbToetQcOChVpvVHg01jTX5yT9vqp6Zunq869t+B2pGSzVi6n0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CIwKmAQCoPfl2sHx6B3MygAhsR8YxySW6PMJd1KUz3o=;
 b=Z9sYG9ugJOCqBEFle5Foavv0NwOl2m6lCTw4QNyHY2iQ8WJUKxSwn9bVdjVswijXkWbbBlH1MCqtA3egu2RdrjVptRybhVF0RdujSgcivKQQcKgjFuU0dyNFUQ1C0JYfojC+l2R/OA9rMmVrcvLA+ZYWGovUkTS5wTJlpX2Rfog=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BYAPR10MB2920.namprd10.prod.outlook.com (2603:10b6:a03:8f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14; Fri, 29 Oct
 2021 19:06:08 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::2ded:9640:8225:8200]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::2ded:9640:8225:8200%5]) with mapi id 15.20.4649.015; Fri, 29 Oct 2021
 19:06:08 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Timo Rothenpieler <timo@rothenpieler.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Olga Kornievskaia <aglo@umich.edu>,
        Dai Ngo <dai.ngo@oracle.com>
Subject: Re: Spurious instability with NFSoRDMA under moderate load
Thread-Topic: Spurious instability with NFSoRDMA under moderate load
Thread-Index: AQHXSnp8j8N6G2OhyUK9Nr2RtJxnoarn3hgAgAATb4CANuhZgIBOXZcAgAAVhICAADVLgIAASYeAgAAo1oCAAAOTXYAA6JWAgAADg4CAAANlAIAAA4eAgAAZh4CAABNpAIABnm2AgAX5FgCABmbVAIBtyicAgAA5xwCAADMmAIAADYKA
Date:   Fri, 29 Oct 2021 19:06:08 +0000
Message-ID: <855BA036-FAF3-404B-90B7-D95AF3A96567@oracle.com>
References: <4da3b074-a6be-d83f-ccd4-b151557066aa@rothenpieler.org>
 <9355de20-921c-69e0-e5a4-733b64e125e1@rothenpieler.org>
 <a28b403e-42cf-3189-a4db-86d20da1b7aa@rothenpieler.org>
 <4BA2A532-9063-4893-AF53-E1DAB06095CC@oracle.com>
 <c8025457-7376-e1b7-bd6c-e5c6ee5d9ce7@rothenpieler.org>
 <141fdf51-2aa1-6614-fe4e-96f168cbe6cf@rothenpieler.org>
 <99DFF0B0-FE0F-4416-B3F6-1F9535884F39@oracle.com>
 <64F9A492-44B9-4057-ABA5-C8202828A8DD@oracle.com>
 <1b8a24a9-5dba-3faf-8b0a-16e728a6051c@rothenpieler.org>
 <5DD80ADC-0A4B-4D95-8CF7-29096439DE9D@oracle.com>
 <0444ca5c-e8b6-1d80-d8a5-8469daa74970@rothenpieler.org>
 <cc2f55cd-57d4-d7c3-ed83-8b81ea60d821@rothenpieler.org>
 <3AF4F6CA-8B17-4AE9-82E2-21A2B9AA0774@oracle.com>
 <4caff277-8e53-3c75-70c1-8938b2a26933@rothenpieler.org>
 <716B2A38-9705-41D7-969B-665EF90156C7@oracle.com>
 <D55A1FA5-71D4-4D37-9B88-E1733BEDBE47@oracle.com>
 <60273c2e-e946-25fb-68af-975f793e73d2@rothenpieler.org>
 <2445C26E-7D96-4E77-8079-98B865CC4C57@oracle.com>
 <774c4839-0165-e660-bbc4-9a8814192f26@rothenpieler.org>
In-Reply-To: <774c4839-0165-e660-bbc4-9a8814192f26@rothenpieler.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
authentication-results: rothenpieler.org; dkim=none (message not signed)
 header.d=none;rothenpieler.org; dmarc=none action=none
 header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 932ae5cf-1c55-4977-63aa-08d99b0f2a1e
x-ms-traffictypediagnostic: BYAPR10MB2920:
x-microsoft-antispam-prvs: <BYAPR10MB2920B87F83C55987332A780E93879@BYAPR10MB2920.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qWqVKVWZS/ZPnN2SJPdI16ZGVVTJQ9CdZoOXANYeybpWQJoPrFhJDMkZ8nE07sfNIRr+AaXwYHfZMH+qr2fOwiBQGpMkiMMC8/EdHAP5lkRW7ET+nYrOq03a+lCM6twJl5iQDimxAgAJtIBQdXaVP4qZl8cYJojVEBeQ50H5/68eVIjf/OaPInniCll7b2r268hAKPNXqbqc96LW+YFJs+8WYpAFQDbqaJqrNrJc2zFcCUWfDK/xZwoe0X0+YrALCAAGWNtavfGo099+l69kWQTGPlHP3b2SkFSgRhGa25i+tTzNAtYFfYP/p1nIfOGjMnDfbfxyABWrGO6eBKtDRmv0AZSqgu79chUN4aCK30MSbz3nOFclZQnx/HlixEruiy3JP3N8jHa6rw7g0WqwMwpCI28di1gJjQK0IVMeWnwDdM4d9UI61HNM/fihCXLHkyXhl9wuuC6EzUSEcMbzroRR2JAOJm/5EBi6ZwxwJOPc3V94AxcDQkYgKD7TpVEAfI71yQWxhG1hKtzaiHFzsLE5tn9XIDiughvQi3x0jJ2Keyl6NSUr48SVavdDuISpI3oZ5/iNrxCRI4sT4D7GDZdfylH8IG/+zZHRhil2DgnO2++0HEUHZnSLbxAdxq+95E0dobyuq5TP3QjcVttfUwKpxl+kf5IgmhJUx0KNolIqn7urxWeU5Ph4uVVhENXC8NBD5icw7A26H1uCIZy13IX5v5hjxQbu3H6BNv2XWhyRjmMMmU7ugU0WZfapKtwnizjtm8K5Pn+JZST1hC/8CkJv4AKpNOJk6PlFEiTlqoq+9BkrEiSsag36WO2xKnwo
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(966005)(6512007)(8936002)(66946007)(91956017)(508600001)(76116006)(186003)(86362001)(316002)(2616005)(54906003)(8676002)(36756003)(66476007)(26005)(6916009)(66446008)(107886003)(71200400001)(4326008)(2906002)(38070700005)(6486002)(53546011)(6506007)(33656002)(66556008)(122000001)(38100700002)(5660300002)(64756008)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Kkx0HhNVffRaQQudd86aipMyKku0+801YiLlN33zAK3DYv/btd2AAcL2SAn5?=
 =?us-ascii?Q?mOjw9zLZArXuTbErcnyU33W6U3dJ2v8AmCXsm0ktfN1UM9+ANU87MLGoZIaq?=
 =?us-ascii?Q?YYjlyi/oxsFbC07DwcIojpPTD/QW3xPBugOu4iUD/ODdaDuwVPR/Iue0Gu5i?=
 =?us-ascii?Q?tTM7yxk1Wl3+WoALx17QXLGQo5yMy9nNHicEGJgu2MkkXMfuio1T1v1MriAC?=
 =?us-ascii?Q?qxZ2j+TsiFP3xGmqhefibP/IGaRMMFXz5veVlRFs99+tcdx3mnmJ32hmqU4j?=
 =?us-ascii?Q?2+3XeVLi2ceREURcS1mixhZTWGei3slVBLNNaPH0yE1CiR09EaxVRhN9viqB?=
 =?us-ascii?Q?B7i0eizH2GUW9yO4gaD3Tcc1NBxhOOVRzfrT64J/xwWeqhIbLeaBsMDh8eix?=
 =?us-ascii?Q?9U0w4aQ4Suitvbn8WR8RsS5JzL8Tr0RVRvw6ksOVPbjUl2B9GNCew7SnsKUC?=
 =?us-ascii?Q?Dxo8+dvuSHSWvqS/8LCyfZt4myhZNuuKprYJUsIbplifB0rYIBzXrkYJ190H?=
 =?us-ascii?Q?SIeCyeHqQJwsKusX4QlJtAA2KcJOJ9lq4N586ZQaDMnDS7/uxZMj+EeCbjEE?=
 =?us-ascii?Q?oGjE3rJvXe9f5pBq55rclSmxBpO9THmiJ09ySYtqG2MhbgB/f0kerr+1ERzG?=
 =?us-ascii?Q?MQsCe+aBnmIFlrwO2jBNC90bkF3xLdLiw2cuWdP7PLO5CF8LU9i+h3mOrEQY?=
 =?us-ascii?Q?0RtSok95aaxZAQh51+N42W2veqIbS/Kd5O9tzTYH0Bx6fnGDz/Eej8SK81X5?=
 =?us-ascii?Q?faQhjiXdNkB0+nOnKczVuvtoxps91zpU2P2rG3nE2Hch38bgpaxZ+9CKzRJC?=
 =?us-ascii?Q?Y4RCwUHvBei4nS8YWGX6QjqWw+aZJffRvVGSxB0lyj7mR8Y7yWO6WjvBnvoa?=
 =?us-ascii?Q?ZLn7u50c49pVBZ/W5kjjBhciw+Fg5lINBI6vDNytoKRj+/dGTTcJAh1InZpm?=
 =?us-ascii?Q?/DzSMKsKtCEWMGaa+1WLoP4qAfB8Nazz8H+IygOK5j8xVoFZ+8mkVgm4O/gH?=
 =?us-ascii?Q?PdAXY7yTjWl/AmbIYPIWb/I7gBUauroQcz9p+ojvUxrIEhbNJVZKKQczWDUy?=
 =?us-ascii?Q?XiMs2uF3smOHXjwDNHijpBXTeyuPUkQjOX1upf80MSSAFbPKgLzIwL5Yhe7B?=
 =?us-ascii?Q?jy6Q69gVIS/jfSDghJoFPoMCWiwsQAifeS8KdM6VPTC4GDD7QIz2RfwbkTJS?=
 =?us-ascii?Q?k/4C5vqGgwcVk01QU/BK/or0mYnlYMtcfpSt51FI7O6ls+Y1WBj4zss6Or/u?=
 =?us-ascii?Q?5qJ+2rxuCYiqUcB1K4kFgkxbfmefSFtoT7bMPVKRVlFpj+Plk8QuxPnGGYyn?=
 =?us-ascii?Q?uiM6AneyqHA6rXLSRNewQWsS5vIApiGRHDLB8PZ9LOzu/lGkzz6RuoRF7jg/?=
 =?us-ascii?Q?Y5pFHmm+n6z7/qaf857JJObOH9Q4VaAOUpwaWOpnMKLoExsCfZnUMdpRKhA6?=
 =?us-ascii?Q?Ggb3+hpcjue1D7HZWZmv0hDOEP2aeRUFellqMZaXa11k/gMP/ZL3TKZoxpBZ?=
 =?us-ascii?Q?UXA73V3U9Tbde+/2IzxpCN2sxoB/pnhCRDAEYB2m5eOumKdiaiGOQZhQGVNv?=
 =?us-ascii?Q?ehR5eDVHI/aSU3HCaDYOvGkWdr3MOgcrUbvcpW2AyKeLaMPVN7m9jOnZ4wPm?=
 =?us-ascii?Q?7xluwDegaL2rVQhQUtF08Qs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C8D66737A2719E419BAF3EB0502EB2EE@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 932ae5cf-1c55-4977-63aa-08d99b0f2a1e
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2021 19:06:08.2657
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: trjTEqSn3mGvD8ysqydn8U1hCfMTNEd7AEF9QhuVbQXgv42Yo+R6bh6nwagBQ39L2QjGHdf9lzcVEBX4LrCXcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2920
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10152 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 adultscore=0 suspectscore=0 bulkscore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2110290104
X-Proofpoint-ORIG-GUID: MlhhfEm5Xsof3dsdt6DKQNs0o0ie0cqK
X-Proofpoint-GUID: MlhhfEm5Xsof3dsdt6DKQNs0o0ie0cqK
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Oct 29, 2021, at 2:17 PM, Timo Rothenpieler <timo@rothenpieler.org> wr=
ote:
>=20
> On 29.10.2021 17:14, Chuck Lever III wrote:
>> Hi Timo-
>>> On Oct 29, 2021, at 7:47 AM, Timo Rothenpieler <timo@rothenpieler.org> =
wrote:
>>>=20
>>> On 20/08/2021 17:12, Chuck Lever III wrote:
>>>> OK, I think the issue with this reproducer was resolved
>>>> completely with 6820bf77864d.
>>>> I went back and reviewed the traces from when the client got
>>>> stuck after a long uptime. This looks very different from
>>>> what we're seeing with 6820bf77864d. It involves CB_PATH_DOWN
>>>> and BIND_CONN_TO_SESSION, which is a different scenario. Long
>>>> story short, I don't think we're getting any more value by
>>>> leaving 6820bf77864d reverted.
>>>> Can you re-apply that commit on your server, and then when
>>>> the client hangs again, please capture with:
>>>> # trace-cmd record -e nfsd -e sunrpc -e rpcrdma
>>>> I'd like to see why the client's BIND_CONN_TO_SESSION fails
>>>> to repair the backchannel session.
>>>=20
>>> Happened again today, after a long time of no issues.
>>> Still on 5.12.19, since the system did not have a chance for a bigger m=
aintenance window yet.
>>>=20
>>> Attached are traces from both client and server, while the client is tr=
ying to do the usual xfs_io copy_range.
>>> The system also has a bunch of other users and nodes working on it at t=
his time, so there's a good chance for unrelated noise in the traces.
>>>=20
>>> The affected client is 10.110.10.251.
>>> Other clients are working just fine, it's only this one client that's a=
ffected.
>>>=20
>>> There was also quite a bit of heavy IO work going on on the Cluster, wh=
ich I think coincides with the last couple times this happened as well.<nfs=
trace.tar.xz>
>> Thanks for the report. We believe this issue has been addressed in v5.15=
-rc:
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commi=
t/?id=3D02579b2ff8b0becfb51d85a975908ac4ab15fba8
>=20
> 5.15 is a little too bleeding edge for my comfort to roll out on a produc=
tion system.
> But the patch applies cleanly on top of 5.12.19. So I pulled it and am no=
w running the resulting kernel on all clients and the server(s).

Yup, that's the best we can do for now. Thanks for testing!


> Hopefully won't see this happen again from now on, thanks!
>=20
>=20
> Timo

--
Chuck Lever




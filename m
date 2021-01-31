Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C549309EFA
	for <lists+linux-nfs@lfdr.de>; Sun, 31 Jan 2021 21:39:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbhAaUji (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 31 Jan 2021 15:39:38 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:45816 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbhAaUjg (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 31 Jan 2021 15:39:36 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10VHZ3pa012481;
        Sun, 31 Jan 2021 17:43:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=UhTr8WsO8DQYfsIxbC00xwvCAoM9eZUIW5deG0aDbvQ=;
 b=uCxLxs5aacBrsXoePmk7/gbNtVp0rnxcRl5063Ho9+T7/ZRIs1871PsC4rVNmVdbGoRF
 WXirw/XC3WNEbibSyTs/rjxzMgBgx0AOFTJ/17YqgeB0NanL9mFf5VnFdAqH+pypfwIV
 tpBvfUBOO8sIjxYhzkhgjNsSLfR9vRG+vgQyp7cjpgLmIoUt6EJczFlLcCYVIGlu4WUu
 Daq6ge5Akh3+D+VxmbXRcCVzMebKJWPdj3QkPypE21esv+xNxh5Hdq2eJlEABzX2zaqw
 iqNHuZVwSxYkq1e7St3QCagcBFKo7azjIMlKSwCvKdGj0hGjWeShg0vTCmjp7hXq9BaM +g== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 36cxvqtnw1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 31 Jan 2021 17:43:18 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10VHaOhC109979;
        Sun, 31 Jan 2021 17:41:18 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
        by userp3030.oracle.com with ESMTP id 36dhcu2crr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 31 Jan 2021 17:41:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=htkqdtbw9gLI6FyUsFMzUG+cPwLchO0bt2r8mTcuaUSXKl5iDEKUVqOqSCDt/8xq8tM722zYh1A9P5BrZ2oBBMJlagLnm83LE646iJv389scRgyfAjKXchM7juRGZ/dwj88rLRiK6OgE8DqFpzovpqUikQy5ADR1zwZakGIqLSBch6ikpdKliDW/78Y5ICjilSRMMrnp5NYcX/V9VNhRSLc2Hy/PJHYUC7PPfFv/NIMLbjzfQJUs0REdJWoJnQ4uUS45hACWZTXeQkAvqtM6/m2myxnE8ZCx/1bV+ojCQo3BsG9tdgNKOl78b03ZD/McJsWqk5Ht1suXvZDHiSBuLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UhTr8WsO8DQYfsIxbC00xwvCAoM9eZUIW5deG0aDbvQ=;
 b=VsRqb6WKLrN/5gvhBH7t9WuSUoKFuWMlCyN98k8eiNEg764g/i7fpGRhP5a2C7BgyJd3gRh6n7BL+qhBApP6TwyCUsYHvBxzwqlDCHjzYLjrpSa0gitsSCLpIxJAFGpUw7I5Ck0jUqipa1GHgwP0/by0600oBd5UrpxDBh77q8K8P9tUrViLA+vQKNqnpyfSQusJbuaKzR0JY88NFS/bq2hLFc8sb1xHiMWRE+9aBUPb60S/XvhV5yPOE+ndw1uphIPE/aIMF5zFED0oCtzAlRpACC7PLXTP+B7pS5FBCc+uRSWX3v3gm42lRH7rQ5aLmO8hTMZuYeGVSVGKpN8+yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UhTr8WsO8DQYfsIxbC00xwvCAoM9eZUIW5deG0aDbvQ=;
 b=QMU8s6LYJzXDfzcHJdv5SKH464bPz6oZEAuifyOsQp5nUSg+LGx9lriX1Y3aHUOEb92kLmT5s3nGARGS8vw0/C2vKlYew0nhND5ArJfDojNqDC9A6z+3ER/UPeU7ZSdZk4ROPAaeNae/aX7o+JBimLyPCkxHyVWTn4JweOLXIPU=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by SJ0PR10MB4591.namprd10.prod.outlook.com (2603:10b6:a03:2af::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.17; Sun, 31 Jan
 2021 17:41:16 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b%4]) with mapi id 15.20.3805.024; Sun, 31 Jan 2021
 17:41:16 +0000
From:   Chuck Lever <chuck.lever@oracle.com>
To:     "A. Duvnjak" <avian@extremenerds.net>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: nfsd issues in 5.10.11
Thread-Topic: nfsd issues in 5.10.11
Thread-Index: AQHW9k69KquWRfbK30WUoKO4pr//HKo+wTAAgAEcogCAAJUUAIAAB6cAgAFiAgCAACdfgA==
Date:   Sun, 31 Jan 2021 17:41:16 +0000
Message-ID: <1CCCA2C2-BE78-4341-88C0-F8536AEBE41E@oracle.com>
References: <68D3109F-82A1-43BF-AA45-6E1C532D3BC4@extremenerds.net>
 <D7596D40-F549-4299-AC50-D81F6692FA13@oracle.com>
 <E154BD9D-3FA0-4EC0-B5A2-BA9DC88D9A4B@extremenerds.net>
 <92F1D388-52EC-4464-80FB-DBF9DDFB08F0@oracle.com>
 <110C9578-0B2B-465D-B1E6-76A6FCF9AC44@extremenerds.net>
 <BA2441C0-2E3E-4E5B-AD62-6ED5930FCDA5@extremenerds.net>
In-Reply-To: <BA2441C0-2E3E-4E5B-AD62-6ED5930FCDA5@extremenerds.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: extremenerds.net; dkim=none (message not signed)
 header.d=none;extremenerds.net; dmarc=none action=none
 header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a8b51dbb-4ace-482a-d5bb-08d8c60f68fa
x-ms-traffictypediagnostic: SJ0PR10MB4591:
x-microsoft-antispam-prvs: <SJ0PR10MB45918FC4BABDEB1126DA5D1293B79@SJ0PR10MB4591.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sCsjonU/zcAcRBI3NEgNKc1DYpFHr5Be+DRiPeXwqU8t4hn7/clxLQqCvoJq17G86WjGYVho+Rl5faO9qMRECu+mRstqWJqJWt1SQtWGgcPkIJyPVfgPLwAksrMM6DJXukiKjUSQ17QxEqfaNW2W+UZRzkJtG98wfsNKVdV9dgvm6KMbdU8p5IZU1Cmq+S1aUuff3t5n5jx/7cF6e0YpX+oNHW9PSWw3ac9StQRKYZTp3ZDw48yiHgBvISQQ0kx8xdyOOnDfaec/sdL6VPJ9S0oSFdOZvTiuaItxz5QiiRXb4PwwysKMa05F9t+VwRq51k6EH+EesmqkGGx3dDatEMh8+WdiKx8YBZ3PlCEyWpCIxAdKVn1PcJ4HAHPSMPHWyqmmqHcU1ZVY0Yt3bdaWtbHnybm18QMEPQcXo99//d4/LsT5Rfu0sOZ2CSowSm8+E6pkEflDAOXluCy5p106vDPNPb4SIRNUuFU7d51ixCYnUIERn5byWTY/EV5kUuLQ4cK2K4TI2inbHj7L0nuSGnTlTJkRgsuNDpsdgpggbvLlLZegJXjHvJDITMpF3U93
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(346002)(39860400002)(376002)(366004)(86362001)(2906002)(4326008)(76116006)(8936002)(5660300002)(6916009)(7116003)(478600001)(66556008)(8676002)(64756008)(66476007)(91956017)(26005)(186003)(66446008)(44832011)(66946007)(2616005)(6506007)(53546011)(6486002)(316002)(36756003)(71200400001)(6512007)(33656002)(83380400001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?OUUR9QvDfg3ZVSZtSw8642L0yD6wOv18vxyshDPDTaJ8vimJZMb0t+NoILhd?=
 =?us-ascii?Q?cbuhPT99bOxuCiqtN9r/09izSf3XMLKuqqAyhtTPFLTR4Ze4NeGqbXcU3lMo?=
 =?us-ascii?Q?IOTccEBOGNjJpwnknKK6BpMIz6++mOh1XuiVkproIhiaBq3Pcl0pYw6+xreW?=
 =?us-ascii?Q?zezOKa1nOXKn9wClt1XAHUSknG/2CVJ8+kufJgd/C3E7GDzzpyeZ1EgYZRyx?=
 =?us-ascii?Q?OE2/HBzyzHUF5Cbzc7H9q7QHkVgl/VWVOeTRW9kTuM/F19PdGKdaezNZMHlo?=
 =?us-ascii?Q?FrZCt6YPXdtFzVAQ2zlh42Kde3niN47hgXNqcb7LcodjOIApGdnR8RoMLAoi?=
 =?us-ascii?Q?f4ygnExXOvVAFStdbXyCpWByrC6JP5sH53QOl1Ii5PxdQfjbORHPvZbmolGj?=
 =?us-ascii?Q?iBQJycHJIvqBMlciaPs0O/IJBlF0k/rb2e7wJNjR/lKBzZnV08b4RBprCgBv?=
 =?us-ascii?Q?w/TQ/IjTUMfDazSL16NtTlnRvsRjf+iasxNge1xVT8hjWKKe8H8NAQFma+Dq?=
 =?us-ascii?Q?ChSa26b2tG0IkzDf8KK4uvvlaUP5OxOmaSrrBHxxFE1GUNWE3SA6cgMaTDJE?=
 =?us-ascii?Q?u6Rrg6jErRpCWByAmgjcBEIkCoHU+QdKQTfdj+zTIBLaFfMPxj9Naky6aLWE?=
 =?us-ascii?Q?XVQ2BE8pSssq+hL+FETb+4XBlO+/j8pVxXrGpa+cfOSLdzzlHciTyF2J6rM8?=
 =?us-ascii?Q?yf0pabAQMseyL03LVR/xgnT9jUvn7wWJXwg3yhLY4FqqA7gl5Gvh03vkMmcI?=
 =?us-ascii?Q?RpmsG9Tf0o9/Db6SbRF+/4ROAqcJg9zDx7OMhecbftTEfRFRpRcIyCYFZzcG?=
 =?us-ascii?Q?9vi1ya9u9B3Xn/8ZmbdEwltyNBSuSR5k94s9y8MPX9VMxX8XqQRCwnKdHagj?=
 =?us-ascii?Q?T/N9+3n7cz4DUaxt9kYxtZYLtTNOAV2SIPsXTsdCB3AiOmLBlR9dz97CZ//3?=
 =?us-ascii?Q?OqXMr38UxphuhuxvdFl7HG2MBYkAWs7CujppIuiNFJL7I0gYTYCHCZVqDt/T?=
 =?us-ascii?Q?uAJtSjmRI6devTDgl6+T1n45No2vAG1a3zxMecPylGospCe5bZ6ipTcimeG2?=
 =?us-ascii?Q?WZGGaSF7JzabadC8L1j3dkbCXO1k3A=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <EFF240729A0E384983C4F4A1E759072B@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8b51dbb-4ace-482a-d5bb-08d8c60f68fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2021 17:41:16.0425
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IY+/2ue4+7xFxqU1TE0ly4QNGj7irVwMk/GNV2ng6jGo+giKstS/zs1MN7HxPMBdw52bW+2Azu0ftw74xCyXcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4591
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9881 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=780 phishscore=0
 spamscore=0 suspectscore=0 malwarescore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101310102
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9881 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 mlxscore=0 priorityscore=1501 spamscore=0 impostorscore=0 clxscore=1015
 suspectscore=0 lowpriorityscore=0 phishscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101310102
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Please leave linux-nfs on the Cc: line.

> On Jan 31, 2021, at 10:20 AM, A. Duvnjak <avian@extremenerds.net> wrote:
>=20
> Thanks for the info Chuck,
>   I've done a git bisect, and have the log attached.  I've also attached =
the kernel config file I've used through out the bisect incase it helps.  S=
eems it traced it down to the "SUNRPC: Handle TCP socket sends with kernel_=
sendpage() again" patch in net/sunrpc/svcsock.c.

I was afraid of that, but I still don't see any obvious
server-related misbehavior in the network capture. The
differences are in the client's behavior.


> Please note the issues arent only in Kodi,  but also in the Windows 10 NF=
S client when using VLC (i.e. completely independent of Kodi).

And MacOS works fine. I don't see how the VLC misbehavior
is probative yet.

We need one simple reproducer and someone to help us with
diagnostic information. Kodi fits that bill.

I can try downloading Kodi and trying it here, but kodi.tv
might need to hear about the problem from an existing
customer before they become responsive.


> Happy to do any more experimentation as requested.

Can you try v5.6 on your server?


--
Chuck Lever




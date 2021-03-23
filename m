Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C99CC3462BF
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Mar 2021 16:26:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232578AbhCWP0R (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 23 Mar 2021 11:26:17 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:49522 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232750AbhCWP0H (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 23 Mar 2021 11:26:07 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12NFOtB8159374;
        Tue, 23 Mar 2021 15:26:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=wMocz+BjtmLPB7Di9RVUczZG1et7TdEr5GeATJbaSuQ=;
 b=HYb7tEhZr7nBN0LaOA2R7GOLFxzacXwf5YtQtUbfSmgnnKf+SQGzXoS+2ar2Ypc2KCve
 AR9h7BgqQmwxO7udkw4ZwPJ5MEQeo1XimF9vBzE3Ln5AiVKvlR2QcywzaMzJjJxx0zFe
 fd3JnvXisDZxU/jDtbcpHvAFryZRwfu+WPhPVbX035ncU3dEgK4/zYmX/3ZgctEb0rIk
 ma5Oktgi7si6IP+CBbfKKacZKumtv+euP/sS/z1Zj/+Qri2XsJfiKNacZZxul5RDCZDM
 TTeu44wO8JPP0MyMfaQ+notMqn/53q1x7BMCFj29IeHgZ18gCnPCNftTW4vw2tS1mnf2 mg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 37d8fr7g9t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Mar 2021 15:26:05 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12NFAjQI061987;
        Tue, 23 Mar 2021 15:26:05 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
        by userp3030.oracle.com with ESMTP id 37dtyxk75k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Mar 2021 15:26:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N2W1XeDxhVXEFfHFEoJoj6TT4KPCOlm2pAhee0L8LHox7YXyQRuHfL4mYXNBkUnVEGp9OQ8dewuy5avGAEngr1sxzUxtAsSM+2/QJmUpsg3UXSKNEAcsnIc9UA2QhSvjtlUeQkwy+HSflaMyBTV5BlNi6kfm+eQCbeX8PczIjvBCsIWAX0cB1nJr1xupfrgEsx8JuNm4Y4wRoSIOl6SOR8ULS0iJDk3Tzo/9+pS++JBbdd7K9qwUsdNeRmChzsfBCwSQtaYaZRYYjvNqeo9KalGvX5+UDbCk11NxH2OKr/EVfjz3fTgum31tbAQzVI/+zZjQrFRJMa7k3jRMvbPw6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wMocz+BjtmLPB7Di9RVUczZG1et7TdEr5GeATJbaSuQ=;
 b=Rb6mrum7FRigyrztdQAqeY1g0G+KRcGz0L6o9dPEJadlhIx0qnVPSSYC+uM05PReBm/wSrT0DFjMP4zWueL+WIDKhejT0MWwkyfrmphT/fwCb2lPX0kp7WEgrvT5gPCyqG3pjVFb47nUd2YRdJjfIbSetcktgdbbR4Zum7ym887OtJELtOuZP5R9Qv+ZATwWT3kyEgHcvvNgrFsLla2103sAj2U5mf7Pgsnjxx8RssWbQw4LYL1QSVT+3VyKhbZeGsuDN7DWeQbRdEhM7QNmKiYTwWi5lsY6lFGfSO5KCfxRmEnOxpSfTxVDK47mPm+8RRX5VPck5QDq1gpQy52bOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wMocz+BjtmLPB7Di9RVUczZG1et7TdEr5GeATJbaSuQ=;
 b=GbHMtbQXy9Q9o3pTXihB8UlQcMWBJdw0UIlN0nWDOqfVNJdLgfibwYz+AKbyv7kZ0PaqHAel67M/P2XSLGKbF3AMaxvalPqP4bKP1aS1Glp+RYJ4+gDa5ukV0Bol8Rz6QkU2kXd87UEvgIIVHxGJolGEKpoIE/VbowlV+i5Oo1Q=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.24; Tue, 23 Mar
 2021 15:26:02 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::50bf:7319:321c:96c9]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::50bf:7319:321c:96c9%4]) with mapi id 15.20.3955.027; Tue, 23 Mar 2021
 15:26:02 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Geert Jansen <gerardu@amazon.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: RFC: return d_type for non-plus READDIR
Thread-Topic: RFC: return d_type for non-plus READDIR
Thread-Index: AQHXH4An0zoT5whq90uvEbXY1zJqrqqRsqoA
Date:   Tue, 23 Mar 2021 15:26:02 +0000
Message-ID: <689DD4DF-17C0-4776-BE53-7F10F7FFE720@oracle.com>
References: <20210323010057.GA129497@dev-dsk-gerardu-1d-3da90cb4.us-east-1.amazon.com>
In-Reply-To: <20210323010057.GA129497@dev-dsk-gerardu-1d-3da90cb4.us-east-1.amazon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: amazon.com; dkim=none (message not signed)
 header.d=none;amazon.com; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 70fdc06d-2a6f-4723-0379-08d8ee0ff83c
x-ms-traffictypediagnostic: BY5PR10MB4257:
x-microsoft-antispam-prvs: <BY5PR10MB4257044CCFFEB9AED0C578FC93649@BY5PR10MB4257.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VFa0tjIaqkZN/98QV8N9W+L8ZAmEVvmHtQJpBte3qxDFKrXM3pq79lWgTgkXUYU8RGPNTsNOYkpLSMhLrDNdMmYDEx5QwwejgXZ43vMq5tQtpKyBNwZL+y7ZBv4rhBx2HjV/hiJH8aFfYryIiRxlf0EfE+LQm96Y6HWNMJSjv9YqyJFWDg+VLmZMalmW3OHRzx5Ig3SmPLoYLe/4Pck1ZE9Yablk5h5nyvTwF+lgCqwjgNU+8grJ9GJzE+zTNDt2Fw96Y3deGdVhWZCJLfTZ6jPhM7E6/0W3qQvcIs8hn5H0Jjzmq23tYMy8higil/re+yPc521pSVkrU66o78VIVnfW1I8hwnsMx31sYK9Tq2SWOuDovjaaVJ1DXZ03wUbjbnDeGRJBj2me9hNYjXIMzgxkbDVx2piKd65KrK4nYtb07rwK38YBmNBjOY9y7TMjXbHsXlSwNFgRpIma+xhbYQho1TjMwHcgFo99nEWrJ8lRyIpoUTVybY9z/P6LnbsCC0o6Nhp1gJuoBqw4l+IGH6Ec6QLZesZ2AiHplhq3Dr57mJepHLgGq13J0OKhq41KWFxm7NrLqE314ilagZ97K8ydVED7O4Qf2T+swcrUcTLd1BNLcIdml8lEZUE1ROmKeF11MZLsCHQMgr7WCb7UWAX9AulEcN0oO8p5x8uzCcq9zZ3lRFSfXw3QkTOri5b1
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39860400002)(346002)(366004)(396003)(376002)(76116006)(66446008)(91956017)(478600001)(66946007)(83380400001)(6506007)(86362001)(8936002)(6486002)(5660300002)(64756008)(53546011)(71200400001)(38100700001)(66476007)(316002)(33656002)(66556008)(26005)(4326008)(2906002)(36756003)(6512007)(8676002)(2616005)(186003)(6916009)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?fMfOyy6ab+ZWrqL5mJQj/onM59mOCiEMfT0oCu+/NjfOeHiSQrDP2Vrfz4UZ?=
 =?us-ascii?Q?sA0itSD0xnFFC4R3hEeEnnhUxCkgfoPk7R8vduimYSBBJr9OBC3mQ/LtIZs6?=
 =?us-ascii?Q?oAROfGgjQ07/BWXi8ciMBcjY2fvlvjcYGDN7ih0vBGvXELJhPKUi901yoI12?=
 =?us-ascii?Q?1biHkW/N2BeQ3tzxw+uGgZKsZy7hKQfl+AFg3xU8HMf4mejVYEViSzjf/5fC?=
 =?us-ascii?Q?Wun8zvbNFsn5fWc/A37a/aQZsa0HNsKosSIGS7izP+mSw4D5azaNZJ5gV2rx?=
 =?us-ascii?Q?yfkGOgZnPYS6Z/AzFtwf+cCk30PROP9C0kHUIj+1hNlX5z6yvgjgEg2HEnkC?=
 =?us-ascii?Q?ggvgybbK7LOS60RFnhYGdH3ySP0j4bgOXV0g5aA3EWbtUhKVbLYEtPoAk3MS?=
 =?us-ascii?Q?rhuJ2NLOAXAO2wCxK/JYC42nJDdvZBXS9Rlejf0QQAhomfbfolIw9FhcfwsT?=
 =?us-ascii?Q?WqKUzR5m0qS9Rlk/sBwP8j3FeyHXKU95VtpYaHF1A4VRAstDd63woJOscwb9?=
 =?us-ascii?Q?bKk2NBAzgxyrNWv54wGFS1JrSQLm+5Cyc5/A1EnLhAgJ5uq5Y+citVu7g/Ya?=
 =?us-ascii?Q?4BqlSHnZ7AfjLyNq6ALw+DRUkwGGB3vLvlGNpIQmJJM2UV1iHZxmVhYMgxaf?=
 =?us-ascii?Q?nKvU44uBRbudrdCD9ZR3oZ7A53UG7Lf6jtHPDDFz/WLPQQYboVR4TcZZ7xrM?=
 =?us-ascii?Q?h5PnIDJuha8UZLozROgoUq7M7Bpzmq4t9AR82+wpw4NdZFDYKRpAPAc/FGz4?=
 =?us-ascii?Q?YNC7/BGdTaX7Esen3iN8+FKDZtKkZYc/ZoZeoidIwzn+3MoRAzkwYopsFBut?=
 =?us-ascii?Q?XTsPkFcWc+fJUmwfKC6GwrhWgHGCkDcxXHhMTexPCliWPB6TMEb7x4M2Nyr/?=
 =?us-ascii?Q?na5m76DbYLXcpUhASdYtvsy6yLVgUROAEssAaIJT6Rk+hvHZ0YMHdyLbBBdD?=
 =?us-ascii?Q?wTJ3NvF1Zfqjwz+ZIXWZH7+bk4d7zFrSjV2luwBFTc7Ro0l7jNmbApv/PRpy?=
 =?us-ascii?Q?hAPLrsLKj6uMtXigK1Hk/tNlUuN8ndnUikCXTmOcDbO7U4Bhq3kaw0ZaHx3U?=
 =?us-ascii?Q?Z+OlRtymFmHg70Bzku/XWkLUllgvXNVwPagVCzuJ7A3XwRbRexuG6BmrFN8X?=
 =?us-ascii?Q?GokXtmZe2DJuZPx4DulQuOkOyysxk7GAVoEiUwcwo7C0GW7e3OPjMeonMxbq?=
 =?us-ascii?Q?/rgs9Vg8W+QbG+Xv3jpTgABC+lIE0xjnGgfqPNi4MUXm1LUVJZ2W2V4EEXo5?=
 =?us-ascii?Q?7WsmeLmVxzD6gvPMft/ZYGwk/RF/Cx036jhgMeUjSo7aT7qw7/1ZOYxmFiVA?=
 =?us-ascii?Q?/IWPnoMmT/JIzbEIVXtuBNeg?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D78B5C8C87D02648966A881B562D3B04@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70fdc06d-2a6f-4723-0379-08d8ee0ff83c
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2021 15:26:02.8532
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 34nr3SGxmwL6s0bIaVUWt7/oNluGp7ft5id1IIC6R3CoregUqnjiYwuxG1BIuImHv8Qr0mxF3MKpJ63MVka+mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4257
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9931 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 phishscore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103230113
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9931 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 spamscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 adultscore=0 malwarescore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103230114
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Geert -

> On Mar 22, 2021, at 9:00 PM, Geert Jansen <gerardu@amazon.com> wrote:
>=20
> Hi,
>=20
> recursively listing a directory tree requires that you know which entries=
 are
> directories so that you can recurse into them. The getdents() API can pro=
vide
> this information through the d_type field.
>=20
> Today, d_type is available if we use READDIRPLUS. A non-plus READDIR requ=
ests
> only the "rdattr_error" and "mounted_on_fileid" attributes, but not "type=
", and
> consequently sets d_type to DT_UNKNOWN.
>=20
> Requesting the "type" attribute for regular, non-plus READDIR would allow=
 us to
> always return d_type, even for large directories where we switch to a non=
-plus
> READDIR. It would allow the user to recursively list directories of any s=
ize
> without the need for GETATTRs, and, if the server supports this, without =
any
> stat() or equivalent calls on the server. For some use cases, you could a=
lso
> mount with '-o nordirplus' to scan an entire file system efficiently.
>=20
> Since not all file servers may be able to produce the directory entry typ=
e
> efficiently, this could be implemented as a mount option that defaults of=
f.

Can you say more about the impact of requesting this attribute
from servers that cannot efficiently provide it? Which servers
and filesystems find it a problem, and how much of a problem is
it?


> Some local file systems offer a similar choice. For example, both ext4 an=
d xfs
> have an (in this case mkfs-time) option to store the inode type in the
> directory. If this option is set, then getdents() always returns d_type.
>=20
> Would a patch that adds such a mount option be acceptable?

I'd rather avoid adding another administrative knob unless it is
absolutely necessary... are there other options for controlling
whether the client requests this attribute?

For example, is there a way for a server to decide not to provide
it if it would be burdensome to do so? ie, the client always asks,
but it would be up to the server to provide it if it can do so.

--
Chuck Lever




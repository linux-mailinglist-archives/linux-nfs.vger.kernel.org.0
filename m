Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24F3540B53F
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Sep 2021 18:49:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbhINQuc (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 14 Sep 2021 12:50:32 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:48684 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229482AbhINQuV (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 14 Sep 2021 12:50:21 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18EEh8A8025165;
        Tue, 14 Sep 2021 16:49:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=Cdrntljsse6mpbDbqvD1aDIyXWS450zoYJCVZigT+ac=;
 b=xfjtIDwN43wyQN+0Kgi/6mzdLFZf0pTtAgHhq9I9bwE+q5J4UQkladRh+WPki1VPa8mc
 nIvy6FKY/KSwlL49Le5RjWr9TEwJ5HMYFzcuMxxOaiebuJ9Yj5xFK+aXRLFFamntLeAT
 fTkSJdIFkHl2teWr1gKbdRR1l6XVcJnm7HRgD98KYyhxFIuCfwsKr5V2y8BiEWnXliD6
 ZqrlKtFbD8hq6u2Jinutg/0xuULZbVbZmwyzPxwF5T1ZQVrNVu3BsyEcMJwp+MqCku2E
 aUyXSNmRyv8KbXnnO6+XFwnUj+pqnuxg1Vl9iHJetaUq0ORsLbi0hHQ+L1PRa9mXFBhv 9g== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=Cdrntljsse6mpbDbqvD1aDIyXWS450zoYJCVZigT+ac=;
 b=yN8GLcR1j/HEY2GJ1plRKodS7Mymir3lJKVTkHLdPViVo6RRGOj6ET5FbKD+wZfOJXvn
 HQJLFhdUBgdjtg8vhk7JmAxA+0Fl4FWLCGrzgd2QP65FB1gibKFN0XEQWI9B6Ksqxiju
 hwdQiJg1arPNtaKi5NfYvLkWhEn9JNvspn11Nefz0uITNepIsmd5x+68pOAs8VAtdPn9
 u+Q1OBXSiSpz711+8bzGFEpqn85fWb5Fb1pyKT6sJtZjnW1oamg1j/R4jbU7BIq9o6c4
 x09+UO3sUcFujv+yiozwXnNDEnFSjBJ3YAvuoSyI6aLG2a4I2yRR5rcTMlmEvb057cA2 QQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3b2p3mjaqb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Sep 2021 16:49:01 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18EGXH5u083868;
        Tue, 14 Sep 2021 16:48:59 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2042.outbound.protection.outlook.com [104.47.74.42])
        by userp3030.oracle.com with ESMTP id 3b0hjve3gc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Sep 2021 16:48:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ffsBYpQjJLMJBdhlTeGXBhL4GH8YR4XLjzc9HibGhuZDwHaNeGa9oGIP4RkuPMTsVhbrwTxeagFJnSyRUnoIRws42Y70N5gHxjmMohj2sdzHQXdNUjjucJZhRcmeM98c1+W6/DEmkv5dgwjcFYkM/GeamIiWusabpstd1xGrc8Ng3xeoKLai8h/RS6IQVONGWI9WRTfCKfYtWfm95EEJSiD/rR9H20zgjw98O9fZTs90UNBtl4b2696DUB7tAQr3N7sV4lsXHSn3tfzxp/VHIHLmQt6/J6NFff5kYg+Ls4Q4u0CN3rgE9970cq7aeEYwMzBxDQo4D74Pl46EXSOpaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=Cdrntljsse6mpbDbqvD1aDIyXWS450zoYJCVZigT+ac=;
 b=RAO2NwYvF7DBoCWPkffDXrnbdwudA+rIPqfQW8NMd/4NplCD1JVAL2grEAIyUkWgqS8C54PfufEelWfui0YGXbzD3ouL9t1WHLudiR9U/4vs28pT12OL9xz/lKkiUTbtDH6u5bumrMjf7yzTW1/h82tFwW+A3+Yf0DM+P+ZNjUfrWmcEes8qhoHRv8aQKDe/IuP1z9P9CZ0w+7Z3ndqEn+VXoZi7GaeaXUzU1lgGmaWDMT77YgyjfETWmUgVZLYvPLFc1o6XLRiENFKdEzFIM5gzaqPpAi2bM3hWf/Ej01POtXcBe42r2Lu2PpytWtQ/aKHi/V+AY3iIZ0goR+a9OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cdrntljsse6mpbDbqvD1aDIyXWS450zoYJCVZigT+ac=;
 b=tdZSGVhSYAlx2qZuUiakBNCpuGSS23s0Dm/haDgkJPROsEVXyn2dXcNDMPKNjuAIwRykaeSF5jHl1svF20oMgZIkcszIdbjlXZHtf0Ir7zX9+rchPvEtI7XQbkj5ukVOsIIXEV4vtphPc58snGbb4YKoOLUWh6Z1ACra9Zfh1Kg=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BYAPR10MB2648.namprd10.prod.outlook.com (2603:10b6:a02:b3::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.17; Tue, 14 Sep
 2021 16:48:57 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::f4fe:5b4:6bd9:4c5b]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::f4fe:5b4:6bd9:4c5b%6]) with mapi id 15.20.4500.019; Tue, 14 Sep 2021
 16:48:57 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Bruce Fields <bfields@fieldses.org>
CC:     Jeff Layton <jlayton@kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [bug report] nfsd: Protect session creation and client confirm
 using client_lock
Thread-Topic: [bug report] nfsd: Protect session creation and client confirm
 using client_lock
Thread-Index: AQHXo790A7Wd0tfa/0e3moKXgUhSZquYZ4qAgABDIACAAf4ZgIAAAbgAgADWPACAAEaCAIAABwqAgAf39ACAAAMaAA==
Date:   Tue, 14 Sep 2021 16:48:57 +0000
Message-ID: <6BFF777F-FD2F-4950-BF32-E2DC69C3C713@oracle.com>
References: <20210907080732.GA20341@kili>
 <deba812574c9b898f99fc08f0c3fa23e85fc36ca.camel@kernel.org>
 <622EC724-ECBF-424D-A003-46A6B8E8C215@oracle.com>
 <20210908212605.GF23978@fieldses.org>
 <23A4CB30-F551-472F-9F2F-022C40AE1D70@oracle.com>
 <b63e52660e39cc7688921f85eadf1958ced6a869.camel@kernel.org>
 <57B147B6-FC8F-4E70-A3E1-D449615B8355@oracle.com>
 <c72e78075bcdc174e5786aa6678655fdae73eaaf.camel@kernel.org>
 <20210914163750.GB8134@fieldses.org>
In-Reply-To: <20210914163750.GB8134@fieldses.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: fieldses.org; dkim=none (message not signed)
 header.d=none;fieldses.org; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 79a862b1-c8fa-49c9-a2c2-08d9779f8b92
x-ms-traffictypediagnostic: BYAPR10MB2648:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR10MB2648C6814192727F9D70C25E93DA9@BYAPR10MB2648.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: y5og5KjKme5WJFlflyfWxQCCzTHvrdHMiqAaRSEogFRL4omroroKlb4aa3WWsCP2MKR9iue5ZV7ci5RxxR7psZ043jfK/0FKBYgdU6+7pMm+LQoYo7wRURJwxluHLcJzSbVY8yJelKYFPX3mBYRoZqjCEogUkO+yIylusoH+KJfir5aVM3viKftosv5b9dk2jft2FG2sZvuiLGLGdvqop98gmngnoVTOEGpIPMmybAz4bJGG+DAzTMeickA6mjbV3x0SibxG4uN08aAW8HrNLFI9BAp0qfOgZzlVfsCQRrQrsgGmsFzswxxykES18r+6/jPx3YFCbpiu+u4FL0Wr2aW/L5+ruk/a7zmbeNBabcby66tG0I+kQZf2GJNtEMGaYiT7fZmDJu94bxrahbiAkVgEJC85qAuBR5TyG+wpRNxhPLhUvMXZkOkbueyA20b+OcQLtrQtBmlEThm/nuvbxbfm3rTS1BAYDSDzyaMDs4Jk++J7OUj0Q6egPh3eTicvwO0xxOIBnWQaCPoLzduYPLGlyf9z9NQ+I+TO0pP+0/bQhG2J5HebtEI+6DN5sZa8EFvfyaPDFJhwHhy9GHSPfc8FzaGL2oU3lYJP7UZdh3eXQQ7pwcT+23DvCLvBF0HOx6RvT8FpU+qGnNCga/fRegA6VUnZcAYT0ADxeqcYCa0Ipdahk0dpB1x1C6kWvhUUOKwMTJwTncB586ASgyfmYCIknZEwpLxSWJfYsxXmJqHSmnx6hodW/LI1cqH/3muD
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(136003)(396003)(346002)(376002)(39860400002)(2906002)(4326008)(86362001)(54906003)(36756003)(316002)(6512007)(53546011)(66476007)(66556008)(64756008)(66946007)(76116006)(91956017)(186003)(33656002)(71200400001)(122000001)(38100700002)(478600001)(26005)(83380400001)(8936002)(2616005)(6506007)(8676002)(6916009)(66446008)(6486002)(38070700005)(5660300002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9w9DqVUAhUuVHGSvXbBZqeRBB3o0dAuHEQYcQA3Dqq+BL3cAVKr7fdmwTmtl?=
 =?us-ascii?Q?i460fIUOLk2aBkzG9LvSrsb9oiQ5mCYzGy3/h97BTTTfdJoRF9RcG2lwQF0E?=
 =?us-ascii?Q?fyzOX940Wv1ywrR3Tfq4F0Ai+YXZ5LoavWZO6S/tyEHEX4fTUuYfiP8B2pVU?=
 =?us-ascii?Q?CWSuhcjH6xUT0onXsFw3jdiGb0CMFxbVosf4NAFGJk2vCBY1EtalD6dmCqPz?=
 =?us-ascii?Q?0jpm6oMwy2Zhb+ixSHJSGWaTiwhq1t0QGo1VVBwwBw8RpvQPMmclqzRIz3CQ?=
 =?us-ascii?Q?I5O/iha+suUkW0YkzguXiZ2jteO0hu0xjLUEOKcoJE6mDcq2HCso0QTRU6la?=
 =?us-ascii?Q?0ckLa6V8JzkpeH7zPJS+V48SpDEDORT5f8rJYIucebkkS36W58qpbkQwhRP/?=
 =?us-ascii?Q?VKKa45eoJTVvFF8Rtd2M5Bca0PbWG2P93eLEcMeJbW3HSYcj8GWlK6BOi+VP?=
 =?us-ascii?Q?lJZNrlO6AirWBd48sTNBP948tMwJVwYEdrv5+O3ED0NNCr/B53jIZIytxMJl?=
 =?us-ascii?Q?LufDsF/1lHuDSwG/SFIdZ5GYE42hk3HQZGIKM/jPNe9VJf0yNm0jVS9x/MsZ?=
 =?us-ascii?Q?bgZ12WaMqD/6VKBsVIJJen8pHB1dd5qF7sX4rrwttgpO5h5uFcSIomTlHOfY?=
 =?us-ascii?Q?0wEzGrrCUmgL1yhp9LtiekLpfrXJcy+3EoshHArtsP6ECHpk0QSsa32cO0f4?=
 =?us-ascii?Q?+MVO0Bwi2RokMEJqhepcbYJlpeTnMvfw+exza9uoua+usEGxgbZ+o5QPhkjP?=
 =?us-ascii?Q?dgJfAI6nw9IZXsuOzvwHh9MIIq/ENRXEpuBpETCT+BHob7zUiHKz4fWQg1C7?=
 =?us-ascii?Q?Z+uI4b4CF9i/bE/1jMkVyhOIxuAn8aqohgjsCWbW098beAdtpA2SxuaWzvj3?=
 =?us-ascii?Q?DVfax4hA7U4w7rerqUtZxlZpnVLseCSoIUjIRsThYmhmuVXDy1oY2H6SBC3G?=
 =?us-ascii?Q?4nOGi+j3fAoPOtJ0J12FvefX+JPGTmYI5ASyPb+wMOK4eMu4PHJaptnB8jMs?=
 =?us-ascii?Q?nBQAqIGkcdeFYB+qyS0KFzGrqnLbcyfyTwvC+ba3+YUKf+7aoSh9Z9RSPQQx?=
 =?us-ascii?Q?HzVd5jgk2OL/zWFfCUnhi0uxtSO3XCtPA/ST5ed2/WtP8+CsNTPHcnT+KaDG?=
 =?us-ascii?Q?+y+hkL8I8dp20fADHlT+aYlARJKiCLILRZPIyUI/8Izmi/ItNSOoKPHFvwCn?=
 =?us-ascii?Q?JNUS+/NByRP1D5RxmgyRrGF0GMik3+RK7363lWyVkn6QZDIV1M7NNZf5fZSV?=
 =?us-ascii?Q?ucBGnk1NWV3yaQi6SPotBB2oMz7B25BskSvAVC9zIMOugpNQR+3khLXYSoq4?=
 =?us-ascii?Q?093a29CA7nEeTHxuqZ7zgJXf?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <FB9A6086DBBFB642938E193D0AF10382@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79a862b1-c8fa-49c9-a2c2-08d9779f8b92
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2021 16:48:57.4117
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kMmXTvtaH3Qbib5x1VnlAD2LjZaZrs0w9T6hRmF1slJ03oWNBAmlNJMMC06LprW9urVgQJ83h2JJsFd2p9uiFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2648
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10107 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 phishscore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109030001
 definitions=main-2109140096
X-Proofpoint-GUID: YqEzpfbQAselqK_kx06mqTqgdizXN7yU
X-Proofpoint-ORIG-GUID: YqEzpfbQAselqK_kx06mqTqgdizXN7yU
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Sep 14, 2021, at 12:37 PM, Bruce Fields <bfields@fieldses.org> wrote:
>=20
> From: "J. Bruce Fields" <bfields@redhat.com>
> Subject: [PATCH] nfsd: don't alloc under spinlock in rpc_parse_scope_id
>=20
> Dan Carpenter says:
>=20
>  The patch d20c11d86d8f: "nfsd: Protect session creation and client
>  confirm using client_lock" from Jul 30, 2014, leads to the following
>  Smatch static checker warning:
>=20
>        net/sunrpc/addr.c:178 rpc_parse_scope_id()
>        warn: sleeping in atomic context
>=20
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Fixes: d20c11d86d8f ("nfsd: Protect session creation and client...")
> Signed-off-by: J. Bruce Fields <bfields@redhat.com>
> ---
>=20
> net/sunrpc/addr.c | 40 ++++++++++++++++++----------------------
> 1 file changed, 18 insertions(+), 22 deletions(-)
>=20
> On Thu, Sep 09, 2021 at 10:56:33AM -0400, Jeff Layton wrote:
>> Hmm, it sounds line in the second email he suggests using memcpy():
>>=20
>> "Your "memcpy()" example implies that the source is always a fixed-size
>> thing. In that case, maybe that's the rigth thing to do, and you
>> should just create a real function for it."
>>=20
>> Maybe I'm missing the context though.

The scope identifier isn't fixed in size, so I'm not sure how you
got there.


>> In any case, when you're certain about the length of the source and
>> destination buffers, there's no real benefit to avoiding memcpy in favor
>> of strcpy and the like. It's just as correct.
>=20
> OK, queueing this up as is for 5.16 unless someone objects.

IMO Linus prefers strscpy() over open-coded memcpys, but it's not
a hill I'm going to fight and die on.


> (But, could
> really use testing, I'm not currently testing over ipv6.)--b.

Seems like you could generate some artificial test cases without
needing to set up IPv6.


> diff --git a/net/sunrpc/addr.c b/net/sunrpc/addr.c
> index 6e4dbd577a39..d435bffc6199 100644
> --- a/net/sunrpc/addr.c
> +++ b/net/sunrpc/addr.c
> @@ -162,8 +162,10 @@ static int rpc_parse_scope_id(struct net *net, const=
 char *buf,
> 			      const size_t buflen, const char *delim,
> 			      struct sockaddr_in6 *sin6)
> {
> -	char *p;
> +	char p[IPV6_SCOPE_ID_LEN + 1];
> 	size_t len;
> +	u32 scope_id =3D 0;
> +	struct net_device *dev;
>=20
> 	if ((buf + buflen) =3D=3D delim)
> 		return 1;
> @@ -175,29 +177,23 @@ static int rpc_parse_scope_id(struct net *net, cons=
t char *buf,
> 		return 0;
>=20
> 	len =3D (buf + buflen) - delim - 1;
> -	p =3D kmemdup_nul(delim + 1, len, GFP_KERNEL);
> -	if (p) {
> -		u32 scope_id =3D 0;
> -		struct net_device *dev;
> -
> -		dev =3D dev_get_by_name(net, p);
> -		if (dev !=3D NULL) {
> -			scope_id =3D dev->ifindex;
> -			dev_put(dev);
> -		} else {
> -			if (kstrtou32(p, 10, &scope_id) !=3D 0) {
> -				kfree(p);
> -				return 0;
> -			}
> -		}
> -
> -		kfree(p);
> -
> -		sin6->sin6_scope_id =3D scope_id;
> -		return 1;
> +	if (len > IPV6_SCOPE_ID_LEN)
> +		return 0;
> +
> +	memcpy(p, delim + 1, len);
> +	p[len] =3D 0;
> +
> +	dev =3D dev_get_by_name(net, p);
> +	if (dev !=3D NULL) {
> +		scope_id =3D dev->ifindex;
> +		dev_put(dev);
> +	} else {
> +		if (kstrtou32(p, 10, &scope_id) !=3D 0)
> +			return 0;
> 	}
>=20
> -	return 0;
> +	sin6->sin6_scope_id =3D scope_id;
> +	return 1;
> }
>=20
> static size_t rpc_pton6(struct net *net, const char *buf, const size_t bu=
flen,
> --=20
> 2.31.1
>=20

--
Chuck Lever




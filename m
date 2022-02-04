Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA5A74A91CF
	for <lists+linux-nfs@lfdr.de>; Fri,  4 Feb 2022 01:58:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356051AbiBDA6F (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 3 Feb 2022 19:58:05 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:10906 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243733AbiBDA6E (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 3 Feb 2022 19:58:04 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 213L4JTC020837;
        Fri, 4 Feb 2022 00:57:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=Irsv3+SnUt51kVVMWubbU/wUBDBcc+PVEVkUJ0QuT3c=;
 b=gp4cYkTBBoBaUyttHcMGsW7/dc+tQTYwRnJmbzk330/RTF+7/J7lalz2QQ2FAl96LvpW
 skKrCNbw5wM4d8X3VbIuKQ4d1pPS95xy9VGW4oS2d5n82JS43LXD/BcuI36ZW84jQpZ2
 8bDSN75WjilFBrT1x/6480Z6sS8Tff0KRR4aUvpu6iMm5CVG+tHlHQrk6HUD+SgxwoAs
 rbqIev30icPnPp1LgqzJNWXTas7AZ2RcrvTIkZRBun+qqd1Uv18MpCP5UnKLO0v5HVzK
 +jgU59V5zs7fOsS7BCKWHXVxbE4tOoYqfPrHX9XJ0Mi9PkAJsH5S/ozeA/WXGLmhAfnl ug== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e0hfssbna-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Feb 2022 00:57:59 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2140fWfQ175293;
        Fri, 4 Feb 2022 00:57:57 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2172.outbound.protection.outlook.com [104.47.73.172])
        by userp3030.oracle.com with ESMTP id 3dvtq6cxqy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Feb 2022 00:57:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qx472z9lbIrsHAbl71wDZg6CBg3odEHI9921POzS4/Hp3vG90rjS2T16BEkjMECDp6JwY6zDEd+Z2D1rNytJH4pFmWiLbyIDx/RYghLgXgzm6OT2VSgEoqtidO/wqrpniXGz9prfUuNiBdlCk/r+8D5JWhz4qHVCi8kr98L5T4XhPUIeCBYB2DIaAWo/T5qNB6FtzzgMOQqkpBcnwd31jutuFoJy6vNDi5ksJ/rvrf4Wvj+TnpyM0dMIHdPtE1uYBJE0KQV+U9mlnEAO1dX/gWd/SRDh5DtugQjcPqjhPVYeLs285R+LvlzyWAePfw0Nrp6a1xQsDft9UYKOCouNVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Irsv3+SnUt51kVVMWubbU/wUBDBcc+PVEVkUJ0QuT3c=;
 b=ZQxGq7e/3XKNEI+VHC7Gcmha43p/V1KBKWQYmYMobLvu/4embVMA5TfVqdj4LgkWhvsVutQvCgExHuL8BnLiI+49auZN5Z4Q/N5sGU3W5mDVkz0IUcnZG7GBzFQnf8Qi87Ffcn29nPV4UEEzDMp4HW7o0BEF+3PnlSH/prqhGbrLWxC//49U6sxz+sDs68r1hWJWNY8BvXz8TgeLpJR1Iy+URCvylflOjjwDX7HNIdx1YNxQMC0at9tnm7PDDvLFHo4dZibcbTioDzQQcKstMXVqmQYxpYAiwLwi0Axwm0Pk/p91fRxA8FBp0f7ZsQOgXYLyJqCcZALKfgtzGnMmiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Irsv3+SnUt51kVVMWubbU/wUBDBcc+PVEVkUJ0QuT3c=;
 b=sVQ+rLQ7VtQ1GUnNeb3h0l681lji4uN2pz3Rx3eAKEDz+EoWOBxIaFyLnaNGtO92uTO/j10IVphVrm9+USaZeXe+U5BDu1QFpuFHaNa1lWVlvZjZHH5wkDbIL+mriT2WeDi7/N4GHQQExMHalA9VWGHgrBon7J6FxwGzG0SgQmg=
Received: from CH0PR10MB4858.namprd10.prod.outlook.com (2603:10b6:610:cb::17)
 by PH0PR10MB5658.namprd10.prod.outlook.com (2603:10b6:510:fd::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.11; Fri, 4 Feb
 2022 00:57:55 +0000
Received: from CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::1490:125c:62cd:6082]) by CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::1490:125c:62cd:6082%4]) with mapi id 15.20.4930.022; Fri, 4 Feb 2022
 00:57:54 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Simon Kirby <sim@hostway.ca>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: Cache flush on file lock
Thread-Topic: Cache flush on file lock
Thread-Index: AQHYF9ij5r5wZxOe10G+VO/hoTSM1KyArgyAgAHmvgA=
Date:   Fri, 4 Feb 2022 00:57:54 +0000
Message-ID: <6E2B4CA1-69D9-4B34-A413-5DD86CFDBA49@oracle.com>
References: <20220202014111.GA7467@hostway.ca>
 <4691F0AB-FCDB-49EF-B62B-51F135F692A5@oracle.com>
In-Reply-To: <4691F0AB-FCDB-49EF-B62B-51F135F692A5@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0c6db23a-a979-4748-a7ee-08d9e77960ae
x-ms-traffictypediagnostic: PH0PR10MB5658:EE_
x-microsoft-antispam-prvs: <PH0PR10MB5658D93A5FF23670A84F88AF93299@PH0PR10MB5658.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: j2WGXEr+GQlnVXPpsu6wmmY9cCE4SRvO7kXTngU5PUVrm8I1bZW/4JVidFpx7n+qwKG1GjS2upNSnG2GXG5O7ky8fb+xDbVIq7//vXjIxFUzMTs0ZlRIiHAo+FRD1afb+prIDgRxPeUxvk/lLfEw5/7tP6XBCWPvcrCVvF7jhUJGErWMc4XbKt5TtEEGPUtHb4N6kGkK7KwVhTwE6AC4CnCg2xrNquKSXOKig3bWaxMoMjKMqSKnjfO8w1EZ+UzHHploTTqwYgpw27XKQSPQkAqVuDlrv+I44BkYiWasjvwPfCKHfGuWvQlFQPUB6q3IJvQe9e4nFV5IIr3FJaIjQ7vBY5zriXYrpnpw3EU7zm/GsM4Waz+YwiKSIs+4+TIh4hQQ6JhsBywbMS0p5FiPpHwR77w6WMzJc11AllZpquTNFfLmQNDztm4GWgc0kSCB1aY7N6f3vX0pkje1nEq0jyt/qMFq7iXJphu6W8s+P7wyIxWW+EOPa4Yy1Ugetbu82Dd59KHlljG3fjarAZtQ2uBcJsJkkNybg0WQ0fbtIPF3cZy4xLo4SA3ocqBoJNN2AG8E177/fphfBJ+BAbpGLy3vTmvW4PwjIbxVRk6odKC2IJRE8H9L2D4YSBZxUFGSZ71wj8BHA+tcmaqBk2nXwonfkF6idwPyl8DlaxF6SCsB49ElgVRgTtov36mpmqXWLXvTmrqrFhaucacqMtbiFzSyEuz1K/kBvhOzKRtHUMyea7Wr7vwhcdIFB5G57LhT/pD+58bRx+2Gmq3euikudW9oPAVv+sT+jylFbVB2eNcxO7w9NMgfyDES1nQf2jV876An8NR0e+H7k8abfB++oA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB4858.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6916009)(508600001)(316002)(86362001)(6506007)(6512007)(83380400001)(71200400001)(966005)(53546011)(33656002)(186003)(26005)(6486002)(2616005)(66476007)(8676002)(64756008)(122000001)(38100700002)(2906002)(38070700005)(36756003)(66556008)(66446008)(4326008)(5660300002)(8936002)(66946007)(76116006)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?SfEqtLuG0jstPW6k2I5nWc7sTlzf1Di4t07AGzP3efoXvfi6LXCeKYtmEm9N?=
 =?us-ascii?Q?XzT96WzGxfZLpYl7mG5bMLwABpXy7N15D9Yn5RvUf7V0gKmXPgw33C5Q+JYi?=
 =?us-ascii?Q?+VYPXHn+/0NnsY6Kq3uUfTc3D6G2bu8FgjwKLMy0hJOKsMlNNvplfeEQCtJ0?=
 =?us-ascii?Q?g53OLt8OkGBC5ibRIom5XXQEXWH5DP/073gHO81QvuKVEbcNdMz0pb8Hxuyr?=
 =?us-ascii?Q?XZMv0OhdZ1Eff8ma/9uDrU7cYcv6S7bvlWdMmtqjvbM2Asqb4TW8eLblBYME?=
 =?us-ascii?Q?ycqmjvZk7ovc6dR6pbRzS5Jt0fUON0WU0JwG3EAcY+Bc1XaI5aY/RLd4oERk?=
 =?us-ascii?Q?VFDwOw230pFDjYUB2gggGuKFF3Q03pIoauNQBr5EA1Ek7s5KIAoJGVB/3g3S?=
 =?us-ascii?Q?edGQpOqczMziqH0WNnPIPbRgqVgYblXhyf1JxS5kNdCQ9QIwcLhIPDF20cTO?=
 =?us-ascii?Q?5EXTCvP8K4qkI9mxsgZTgOO9oV0gtlf6iOdlu3g6yPFqbtINsAd2KasJHFw6?=
 =?us-ascii?Q?w4uvqhoARoysWyz8QcOJxn5mCxxbm768H3ettDGKLLpQq8e9Ov0CMJ7QKv6X?=
 =?us-ascii?Q?09b91kmyK5tq/doDew0WkcxIrar3sUq0x56/cK8vIzNAg5W74mVWGYyFfUfc?=
 =?us-ascii?Q?IaIEYDVjA2LYdVkxUMrxi6upoIfEJU17Q6zNSfLBGy9GWqoZ1ZxqjEnpg+C5?=
 =?us-ascii?Q?UkhHMJstkRCwZoAIiTGFl1FwU+6rYclQ2LMXPHbBVeLCcTFWzdyzbZvfznbx?=
 =?us-ascii?Q?fuGlLFypCH3pbSkNYlDG5i89maGGi0hD3uyEnrRPqO2tChq0rp4wijpWA8Ru?=
 =?us-ascii?Q?0vVMbDThZiljg9JCq78To9H//VnkttCA8ZQBIGSdN6WuLh57clquibaSAg0O?=
 =?us-ascii?Q?baGif0hMuS6V8ShJRbraOWK1WHsm7AbNiLOPqgAvV1INh9MuMXmWGVuj/hHh?=
 =?us-ascii?Q?OLKhofJ1OM7Q8TW0Q3pYq5tAMZMv5jXpD9gDrkp479tQVBdH2s7K529KB8Ye?=
 =?us-ascii?Q?aZEhAL6IDfKCNB7VFXgRnfUPJkow0qiOIe+ZvM5qMjtkGCRR90zfu6NXB1h0?=
 =?us-ascii?Q?wn9cuFvLjr7l2LdcdawYKqzo/kJZB0IaEADB451+woboD1JdRA2MXqrvb691?=
 =?us-ascii?Q?X99qg0oKoqNcUqWA0Fmf0DE7BSdzrVSoYjA6Haa4p8NNyH0TIvI6bZMDL279?=
 =?us-ascii?Q?qpbt+ww/B4xxypHPKZ2++1jZ9PvREcpgcKsYzUNHNJc2VxWS/2XKUVerD1St?=
 =?us-ascii?Q?I9Cx9Ticf8yDk4iyPwuDI3V/PU1abcxX/CIuIwgumhPwaq+s2CzN9uFgaU9O?=
 =?us-ascii?Q?hbze//Mwi08u8OJpvahVcBnPBOaFM7tZjLUV+7+mxSTy+oE0GfIojITPGnUd?=
 =?us-ascii?Q?qMYYJeqRo7eyKCS0Q+Qgh37HOPJgJ0v79DSa8QrJLMA6cjPK5E1SGoZAYmzW?=
 =?us-ascii?Q?4+jSwvM1z5HseDyc2OsBS/bxGtJ9szfjNY1k8jbxK8kNK2NHVjnWc5F0VOsn?=
 =?us-ascii?Q?AzhCkm65xRoYlxy4T1DyhukFPBYn22iHHvKc5uJ+npHIo7JSvgbz116DsAhq?=
 =?us-ascii?Q?J6MeASKPE1wrH9BogZgnsfpjUyQMsPDIQr6/esWq8UHOeA3WSmhXBwgiaX9e?=
 =?us-ascii?Q?YS2op+fXSd61cjfHRPtVe7E=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4778866EAD71C84AB44F7DCA7FB0E244@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB4858.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c6db23a-a979-4748-a7ee-08d9e77960ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2022 00:57:54.7972
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ScQ7p1i+R91Pqc95+iKZVNMr+81ltpbfHtXFoAzd4maaws+1i2L0sB1XDveNb1cxlsvGYuaII9q/vUSNVGQXjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5658
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10247 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 adultscore=0 malwarescore=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202040001
X-Proofpoint-GUID: bASAtSCP4AGN-YxiJf6sy7tjFGbMvfWU
X-Proofpoint-ORIG-GUID: bASAtSCP4AGN-YxiJf6sy7tjFGbMvfWU
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Feb 2, 2022, at 2:55 PM, Chuck Lever III <chuck.lever@oracle.com> wrot=
e:
>=20
>=20
>=20
>> On Feb 1, 2022, at 8:41 PM, Simon Kirby <sim@hostway.ca> wrote:
>>=20
>> How far off would we be from write delegations happening here?
>=20
> We are tracking a "feature request" for write delegation support
> in the Linux NFS server:
>=20
> https://bugzilla.linux-nfs.org/show_bug.cgi?id=3D348
>=20
> At this point the effort is not resourced. It's not clear how
> much benefit it would be.
>=20
> That said, it seems to me that your use case might benefit if
> the Linux NFS server offered a READ delegation for the SQLite
> database file even when it is open R/W. It might be appropriate
> if the server offered such a delegation when there are no other
> clients that have the file open for write or that hold write
> delegations.
>=20
> Patches and performance data are, as always, welcome.

You didn't mention which version of the server you are using.

In fact, commit aba2072f4523 ("nfsd: grant read delegations to
clients holding writes") ought to make the server offer a READ
delegation in this situation. It appears in v5.13, if I'm
reading my "git describe" output correctly.


--
Chuck Lever




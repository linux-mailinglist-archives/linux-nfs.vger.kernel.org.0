Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B368B4D3806
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Mar 2022 18:45:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234048AbiCIQg6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 9 Mar 2022 11:36:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235464AbiCIQdx (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 9 Mar 2022 11:33:53 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30E5080207
        for <linux-nfs@vger.kernel.org>; Wed,  9 Mar 2022 08:29:20 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 229Ef4P9016941;
        Wed, 9 Mar 2022 16:29:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=pqVIQZuDVNYJhumuiGwDqlM37KiFIMgWN18qZSlDd6o=;
 b=qLfWEllzVFJYE2lm4n2jwZ+08XPuyE5hIvGVKB2jggyLVhmO0BYSbaOMbHrhQQEnRG5U
 /qO5B2SthCYFOHAmkVtXjOcwx9Sfb6wUWGybsx2Ykt9sRvqNjilfowcOltxryTLE42ia
 mMWrnFlHd7kHSRHyVk5t2rxbnrCIzFZsaJCeEjZck9Hv9wFj6KrhogDewWZdP+rGhBkm
 euvH1hN1nogJAYQRwLiZuperOE6H7mlR3xEO1omEjs/KM6yOlE7hTZwueWo4vBzD1BLN
 MpJ9yCTAXlMTCbtGICk6Qw2pn30YUbjGVUkkfcZSGvsny0qun43697icIG2XOEDas6lA 4A== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ekx9cjgyx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Mar 2022 16:29:00 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 229GBdLk127435;
        Wed, 9 Mar 2022 16:28:57 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2173.outbound.protection.outlook.com [104.47.58.173])
        by userp3020.oracle.com with ESMTP id 3envvmm0xu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Mar 2022 16:28:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jcd2SE1583JBemNgwqqibpPCrRWqUcsoK8sao0Us2my/enQlR2CTTSh6wsAI+n6Hu3s+F5kXvWM+qWBUJ4ChHP/LtMmfM5OqoQmUghRy5W0rwHBT1Z7hwBUyTCAzgZIqgFy7HBa/qvm7LygJJuNSP9tfiatwAtQsj8VNeqTYOFTovJYpA/TmyhAp6enoZQaHXIrI5jdZ1AX5NRGe7Gt47x+VdnrzDLP0kqBxdN/os3ah+8kdjs8kp0KqdEiFl/cE8vaFuU4qmdmIJK6MawAkoGvUUcKIj437ev+3aje8mD2JnGZX4WsFKFSbl2PIG08SeAUl7fRjxWJD4LUCcz/W/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pqVIQZuDVNYJhumuiGwDqlM37KiFIMgWN18qZSlDd6o=;
 b=nDU+NJsvLAHwRSMbZJsgwcr+tJQhq18Y2ubPRRueMetjtlP/YJEveAnSFUzyNo3RAnTNjuQxN7ioJn0NS3njPXGSvn8VmnJexsgw4egMczzWbDJQQ8cnRUw1L023RD4+hwZuLbUJvHTzgK3dGSsOnsoZ+Pu/U5f5S8YuJMzWIo5owJNo0+G4Z/VxOsp7OiN3Q64YXS6na/beXwxP6idOBqqijhBrVFdxuUX6s3MlZYA80xRSbFVg/6SZA85XHoZQNnIryMSWGoK4qGdlAm51YlBmB2nIogGN36IInyCdy3hbXq0vjZLW1w1zuMWX/27kHAfK0MThBIVWwrFa0Nzm/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pqVIQZuDVNYJhumuiGwDqlM37KiFIMgWN18qZSlDd6o=;
 b=Z7F903MpzKPKG0HeL+jX26UFh1IiSYndK19j5c2kdMyrSbMVJLZyWB1l3faUssLEeL8IIGO68gkc6QI40+Gzj47lmCdSFXjaGxleAihR6MqmvsFet4dsztXJITHJualdrq3KBpFWK0C6STRVYj6yYTB4VkGMwDg95hdNLMwcIn0=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SN6PR10MB2478.namprd10.prod.outlook.com (2603:10b6:805:46::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Wed, 9 Mar
 2022 16:28:55 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::29c0:c62f:cba3:510e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::29c0:c62f:cba3:510e%8]) with mapi id 15.20.5038.027; Wed, 9 Mar 2022
 16:28:55 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Neil Brown <neilb@suse.de>
CC:     Benjamin Coddington <bcodding@redhat.com>,
        Steve Dickson <SteveD@RedHat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] nfs.man: document requirements for NFS mounts in a
 container
Thread-Topic: [PATCH] nfs.man: document requirements for NFS mounts in a
 container
Thread-Index: AQHYLR6czeCutPWqYkWZgIa/iwKGvKyqohqAgAJglgCAANDQAIAG3aMAgAKaKAA=
Date:   Wed, 9 Mar 2022 16:28:54 +0000
Message-ID: <398125AD-7CA8-4DAA-80BD-5F65A28FD633@oracle.com>
References: <cover.1644515977.git.bcodding@redhat.com>
 <7642FA55-F3F2-4813-86E2-1B65185E6B36@oracle.com>
 <3d2992df-7ef7-50ba-4f11-f4de588620d2@redhat.com>
 <DDB59BD9-8C29-45C3-ABAF-B25EDDB63E09@oracle.com>
 <D0908E76-C163-4DBF-A93C-665492EB9DB2@redhat.com>
 <E2C56D5B-AC77-48D1-9AF6-268406648657@oracle.com>
 <4657F9AE-3B9E-4992-9334-3FF1CF18EF31@redhat.com>
 <C7533D80-25B3-4722-94A9-0440C48B8574@oracle.com>
 <945849B4-BE30-434C-88E9-8E901AAFA638@redhat.com>
 <06B01290-E375-455E-A6D7-419CA653A0D1@oracle.com>
 <948D8123-E310-4A35-BF04-C030F20EA83C@redhat.com>
 <164479707170.27779.15384523062754338136@noble.neil.brown.name>
 <863AB69A-D5D6-4F22-950C-E5F468CD4552@redhat.com>
 <42AAFEDD-F4EE-4A91-BD23-E08B1149EF1C@oracle.com>
 <3AF29DC6-2EEB-4C3E-BD6C-BE31910921AE@redhat.com>
 <9FC005FB-370E-4AFA-AD80-8599CBFCC1E0@oracle.com>
 <2965D098-7AEE-419D-BF8B-4D7AF4AB40FB@redhat.com>
 <164505339057.10228.4638327664904213534@noble.neil.brown.name>
 <164610623626.24921.6124450559951707560@noble.neil.brown.name>
 <F285A122-30EC-4353-AF10-FBF6999B7F25@oracle.com>
 <164627798608.17899.14049799069550646947@noble.neil.brown.name>
 <1872EF26-5C7D-4C5D-A425-11548477BAA6@oracle.com>
 <164670027879.4945.3527837295426794022@noble.neil.brown.name>
In-Reply-To: <164670027879.4945.3527837295426794022@noble.neil.brown.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b282330c-359c-4119-5df2-08da01e9e790
x-ms-traffictypediagnostic: SN6PR10MB2478:EE_
x-microsoft-antispam-prvs: <SN6PR10MB2478C353F8E078238A91994A930A9@SN6PR10MB2478.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 88mwHDOuQnc8nGEPztgYKqvMktpSZW5pJ4biT7DL0/xNq1SyxeXV3UfwKGkN39X1xbeSvo4Xji/s/K5MWVGncfh6ldwgKnVF9fEJaTAu+Kn7Smq9emwjQwAWaPBZsvJV1K0UEcZRJ2uh/bG2CG9vOLwSZX3Te2ckvMv2P9gQxPEWb05XxgDOXIPitOKCSkEHglJwAHOMQS1LQAazyoEvNFL8R8xLxJB5dzPQPYKtbUmtsaF3Q7NhlyZ+NBwtOD6FrBW4ARf9dVbyz32NXpk6iQfT4HyfSliEV/Z08n75kqcxgpe7JSseCpMNOu5fWoLLmnHWnhFHvzxCqCfRamJudEBMwm4YrDwbwD8TK5kslD1dKVgHzB53YtA4RALBN+1rt9EUKx+cULhm5KaZnzc6sBItZf+IBtBbk1qcop1Zi27mqDNnyUFkph8fAGsDLiTNijWI1pugJCi6i1B5XtbvK7+yxI58IOtiI+yQhnFFykru7HTrqht5V73ziVB4wu1ayjwuKBV0qm6q3w2hjsVp3ipR8UeGNdrwivpowmysY38+wa14LNK/pb6yh2/HyQcNREur2eB0wwVS3HxbSQ08w/uz4P7R7UKt1ILFHYwqtJZ3MAoyjSGuOXkhwWHEq/ZU7/f8K7ZkOIAY72nZVPMyQ7ypzzlKvRopLxdGYyLW/D9DiwTud6rOKpE8UQXK6wg3ojsmnOccuctPOGbtshuK4VKcGkVbadqjV2MGu9vWSxRSjBH0TSFy0HD3HgSHagzu
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2616005)(122000001)(38070700005)(6916009)(36756003)(54906003)(38100700002)(66446008)(83380400001)(316002)(71200400001)(66556008)(66946007)(86362001)(5660300002)(6506007)(508600001)(33656002)(8936002)(53546011)(76116006)(6512007)(186003)(2906002)(64756008)(66476007)(91956017)(8676002)(4326008)(26005)(6486002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Zpd+gd24BEt7f/igZGUGik/NrHhCmnXeRjy8F4t7MqOpiCtS71qJkwVtwdKx?=
 =?us-ascii?Q?M3kSgoL1+ESjgMh8kIZNblhEZR6VV0MgeFVm7GVmirvZl1aznwdN239D8p9M?=
 =?us-ascii?Q?i59+QTE0gaqyR5Io2EdnC29F28R/O/uR0SFbSfX6iq8io5Bo4M3+b2JIHaaj?=
 =?us-ascii?Q?QYhx/5yVGU7OxlvHbQffp4mJS9lWNIcjEl/te6nUz5irJ+VvZFE1S0zXrGcB?=
 =?us-ascii?Q?zG5gQiVPzx/VM1zufC5T1tfxiiZnKHeXPBDsjHtSS2xg48EH/xHR3h3FoCTi?=
 =?us-ascii?Q?t48FfRNDUpieCyucBeOWwZLrbGSk9F4pWWRuvJrJNZTUC4YSJ2+LwePDlxJV?=
 =?us-ascii?Q?W7HcVzdGhKe/fwDJw1xSm+tCalvvZgLLRExF0Is3Y1lmABaL7ym/NVVmDhdt?=
 =?us-ascii?Q?ZxV50SsSuO1Vd/1OTilEMvgh445YUXlMhBAbiSFExcQQ1Jk8MWON06nMVlvE?=
 =?us-ascii?Q?T0CZzkD+875COcQkrUlT5EI0pF4b5BPZ4efG6FsT/IHWk4kda3zAsIhOUVPQ?=
 =?us-ascii?Q?Sq0ZlwLabZDTUvnub4dh2qI0sXsPWgpFIXSYOncrh4n1xP7ZMP1K33xCQuhn?=
 =?us-ascii?Q?Wyj80zVycqvJxA6cxhfmBpZqKyCK8xz6MmV3ZaEYiy4U5BroKwzFsuRS60mq?=
 =?us-ascii?Q?DtM+++9Iy2xr2m54zqhVIFoK2uJIk5zw+lH32ofiB8yyr2JMtpZNoDYA5Zrj?=
 =?us-ascii?Q?oXJU2QqbkVSTABP7yVWVk1c4t9ujWLtaEbUxiTFsI6jHuAuV8wK+vaDZbxlB?=
 =?us-ascii?Q?5oGDG4uulZIF3+OP643lL1k3GMmPz3mM+evnM7lQ9KjihsClFEMFDk1uAJdL?=
 =?us-ascii?Q?4/ubeAGeJi+jU3OVe2RyluC33/vGTMzIvV8sWqKWYxnp9zVTzWWE0IOFzNTI?=
 =?us-ascii?Q?w+z1q5vUjFISXOOtOVHqkPqWCqlTVBq5LQxgu22A+EfAbnw/jyCh6fIAQetg?=
 =?us-ascii?Q?5yvXq5bw1py3ceK9+L03JvmmXUqXyjAlSySVxaVGxGBoelPwUUCg7t5VrNzv?=
 =?us-ascii?Q?vyNAWJa3/cJ/Z1kIGq82WZcBAB3+jrAY5G8otcFMkt/kBUF1ZKEGGeZ8VWqM?=
 =?us-ascii?Q?OJ08cmn2UPD1Uzkhja09OhmzBWKjaumFQqmSPT60H+4pmGQUv2Op++xZrZC7?=
 =?us-ascii?Q?Vw1ZMH6uaT2W4EC5IpZu4sRtCmGm9+h0CVwYmkLdY+ApE8wq5Kxzb1DvvJph?=
 =?us-ascii?Q?Q1FWKq5OKJguhuIB1w6a3rhgd2z+ZxC9mVY4iXSYvOJj9y3Xco/yQ04nDMrW?=
 =?us-ascii?Q?zlFYlenwdx2wPDAkHmffVh3dyydxAGwNeks8TRVnyW97MkLVcBbhG9OBu/9c?=
 =?us-ascii?Q?ZSLH49tdxOZ/PqqJdRpEOmNUB0MDtWxhROYSkkgKGnsb+dwjJRHQ1Ui3cd70?=
 =?us-ascii?Q?O05Y2qHhSmEhC5WQ9CmW8UZ6NwfeiuHFjB3EM34Y6M3MJgcsrb0O2BAecVFf?=
 =?us-ascii?Q?I7/uoOMYFUQltdlcB1Ta9h0Ysz2n1CdYSMOD2ugOG2AOeGZn66WzggU3lzqm?=
 =?us-ascii?Q?lz35kXP55POih2jOBSqK+R82sjU0oCjRyzWnfdWY0oSyAhm4vInuLxNUSJv2?=
 =?us-ascii?Q?8HyelXC0nLC1ZAivWjy2hsW4P/ggI+Wl7ZRJ25OEWhjbmMp3N5izBzm9CqHN?=
 =?us-ascii?Q?+hnbS9sqi5y+yHuwPxttrqc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C13BC6CF69757C42A079257828EF166D@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b282330c-359c-4119-5df2-08da01e9e790
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2022 16:28:54.9313
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xHedzKPhzJu/ZUPqVHR+E6Zo+W2YO4ocCrSy3OGAKTt2ja+7rc5H7faYzMZmI1nyp4zaHum8H6jV0eYFkAiLbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2478
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10281 signatures=692062
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=825 bulkscore=0
 phishscore=0 malwarescore=0 suspectscore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203090091
X-Proofpoint-ORIG-GUID: gA6hbdWth0dmAjCV4Vbsqyh1TQfKU9IJ
X-Proofpoint-GUID: gA6hbdWth0dmAjCV4Vbsqyh1TQfKU9IJ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Mar 7, 2022, at 7:44 PM, NeilBrown <neilb@suse.de> wrote:
>=20
> On Fri, 04 Mar 2022, Chuck Lever III wrote:
>>=20
>> 2. NAT
>>=20
>> NAT hasn't been mentioned before, but it is a common
>> deployment scenario where multiple clients can have the
>> same hostname and local IP address (a private address such
>> as 192.168.0.55) but the clients all access the same NFS
>> server.
>=20
> I can't see how NAT is relevant.  Whether or not clients have the same
> host name seems to be independent of whether or not they access the
> server through NAT.
> What am I missing?

The usual construction of Linux's nfs_client_id4 includes
the hostname and client IP address. If two clients behind
two independent NAT boxes happen to use the same private
IP address and the same hostname (for example
"localhost.localdomain" is a common misconfiguration) then
both of these clients present the same nfs_client_id4
string to the NFS server.

Hilarity ensues.


>> The client's identifier needs to be persistent so that:
>>=20
>> 1. If the server reboots, it can recognize when clients
>>   are re-establishing their lock and open state versus
>>   an unfamiliar creating lock and open state that might
>>   involve files that an existing client has open.
>=20
> The protocol request clients which are re-establishing state to
> explicitly say "I am re-establishing state" (e.g. CLAIM_PREVIOUS).
> clients which are creating new state don't make that claim.
>=20
> IF the server maintainer persistent state, then the reboot server needs
> to use the client identifier to find the persistent state, but that is
> not importantly different from the more common situation of a server
> which hasn't rebooted and needs to find the appropriate state.
>=20
> Again - what am I missing?

The server records each client's nfs_client_id4 and its
boot verifier.

It's my understanding that the server is required to reject
CLAIM_PREVIOUS opens if it does not recognize either the
nfs_client_id4 string or its boot verifier, since that
means that the client had no previous state during the last
most recent server epoch.


--
Chuck Lever




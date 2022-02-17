Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD8B74BA34A
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Feb 2022 15:43:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235426AbiBQOnm (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 17 Feb 2022 09:43:42 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241792AbiBQOnk (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 17 Feb 2022 09:43:40 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8757C1F5CB8
        for <linux-nfs@vger.kernel.org>; Thu, 17 Feb 2022 06:43:26 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21HCuPBg002480;
        Thu, 17 Feb 2022 14:43:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=ld+xCHRBWcHYBPq5CE7bOECFudFSaoneT0UHyYdZqFw=;
 b=ZVuBfnPAM1OR3dLuq/Arjfie0erB/fZGxZyWDizFsoyu6GRz9XcVGZukhYB1JnYp8rRu
 NEOZHov1V9P5hFat2WbWImbv9zdX1eyaQePX+IfHErg4UE0niMywGa4sajx2UvUB60uo
 nl+tEb9c7ZELISqVN5KSLGq9TmJ0Ub7d6EGeDuteih35GGW6D0cTz1SrIknL5g6wPwi9
 Kx19fdiJIZ8I/NC25zmCmFKhH/cMP8WDIS2/zCMrjiKHNxzYQ0VgACQXJUr+McBCW/7J
 sGt6IyOROnvZpavMYgsKx4VlareIf5GRGZlL19mDsFecs9YuwC6j4VQyQxcDAgBqXR5D Dg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e8n3dx5m8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Feb 2022 14:43:20 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21HEfLH0158871;
        Thu, 17 Feb 2022 14:43:17 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2102.outbound.protection.outlook.com [104.47.70.102])
        by userp3030.oracle.com with ESMTP id 3e8nm04184-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Feb 2022 14:43:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RdzSESfc9/vc1DXrcJjTuuLEZ9hLnaclhee2hh3ckH2+YtAf8kKHmfh09E14DoV2q8p6hAw1MqaB+7uzi6beQn3yQjekewP5b7lAFYiQfujgtyoEpznCv6zU7UVKGsQjD6xzSqeIJW9iPyfhU6NbNpsJeLMkSch8FGXFxsX/HYSG97bJSbqfibrAS4EK/+cioTmSYJF0wbk9Lnt3L5E7FxD/wRH9c3jyXFOmXMLmGFFvXOeVPexUIaIgrNaV3QBq1XEJcDTJLBr6/u7zk8o0y0TCHHVWDarXfWzT2ijoo7fcQyqVn5/xVgvmco5umBII1LhaFbU7+YFCxcU6H9qXzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ld+xCHRBWcHYBPq5CE7bOECFudFSaoneT0UHyYdZqFw=;
 b=mbSi12hn/4E7b1a7pXSpMpfC4wypwkAN0yU9pcHDxNb5ElUSM5Hct83P6AYr37NHDyAW3mD5+E0qHzi2wIx93Zpg2e9vxwxJw1k4RN5Ce63bXHRH77GAlzugqOkJb6dUjOPg9bl7bxjhOCRdMrfqBy1N4XvGpeXSRrfrIqXahnH9m4UuA6fA6/jUAv6yBKRCQl9QfK+wUntzwOE+SdYWll76/RjJnDGio1JIGUOYOnNgUNEBU5/feSRD8v/BxDd4lJuByzhpcPyPkA2rNxOj4nsAAMt26vMWQJMyxSP0u/xlsw3bVKnFo0EFd9LSFtSl1ZLaKzzlmGOUTSMnVngCGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ld+xCHRBWcHYBPq5CE7bOECFudFSaoneT0UHyYdZqFw=;
 b=LBrUfqz4FFU+WugaLI7sI/ODKw+yTlWKW08ldf6GKC7cp8nIACJNgH8ebjksjZiximWRa5RSyggrNyMAjqPmCIq4NwqWAAy8KwUzQzf9w9JK8yArubiAGeH0haF5lofr8QyHqTNracU6nZy/9aCJE1ddCWRCKI3bSedX3eC/XOs=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH2PR10MB3798.namprd10.prod.outlook.com (2603:10b6:610:c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.17; Thu, 17 Feb
 2022 14:43:14 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::29c0:c62f:cba3:510e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::29c0:c62f:cba3:510e%7]) with mapi id 15.20.4995.016; Thu, 17 Feb 2022
 14:43:14 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Benjamin Coddington <bcodding@redhat.com>
CC:     Neil Brown <neilb@suse.de>, Steve Dickson <SteveD@RedHat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] nfsuuid: a tool to create and persist nfs4 client
 uniquifiers
Thread-Topic: [PATCH v2 1/2] nfsuuid: a tool to create and persist nfs4 client
 uniquifiers
Thread-Index: AQHYHqhMlT21uFtPcU6l7DrJSxeLtayNFxwAgAFGrYCAACKIAIAALKMAgAAKL4CAAAdIAIAACC0AgAAEqYCAAAnVAIAABAgAgANWcoCAALuNgIAASZiAgANdMwCAAAl0AIAAE0UAgAEtb4A=
Date:   Thu, 17 Feb 2022 14:43:14 +0000
Message-ID: <30D2AD3C-9B30-4B6B-9C78-8E98E1D825BB@oracle.com>
References: <cover.1644515977.git.bcodding@redhat.com>
 <9c046648bfd9c8260ec7bd37e0a93f7821e0842f.1644515977.git.bcodding@redhat.com>
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
In-Reply-To: <2965D098-7AEE-419D-BF8B-4D7AF4AB40FB@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2b849ea8-5545-44e4-f3a7-08d9f223d441
x-ms-traffictypediagnostic: CH2PR10MB3798:EE_
x-microsoft-antispam-prvs: <CH2PR10MB3798E4CC4791688BCC96467293369@CH2PR10MB3798.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KxfnHRlwX3H6z+Af1qZQWfstx4fO23VKe//tLtmXzQh8s/Aub+r8tvd56udk3ziHL6SYm0N8Tt3kawmaARc1S9KodBeScrgyBJc2q/vDbfxE0fXCn11z54zMQZ8XR5UoIMtYLoly0wg3sutQ0BfwwlcEbUbrrO9o20DpvLkN7oGms1vRmCNCxnTCAA0LMp5YeJ8T9g54P03wWjeOpLMFdVLh3g3wJ3zjPAQm8xX0eo0Dodln9pbACuAeH+39e4lbz3AFcZX55jbXukGAra9B41tw2IAkM7OWbd36UAM68RCZeI1bp9HFjeQv4LQrUnt6JIUfmAWnidrWsH8mx1E/VowGIuEsDThA0x6lozyylaCzwPzJCt0ODb9uCXpgWBC2mR7CiqTjbgpxAkPzgkokkG0sk7M0vZfmD7Xqad0gMAC+U2Vy/s/6SRiQR27LzbeJxzg2B8pXxmI8AbPEdn4i6UHHunIRuZ+scvcKgfnrB3+q0JA4e3IMQsMn7Y/TOrePh2wJ1WAQ77sCHK0mF9RXRfFDSuUpth9K16wUtks+RWgyC9MHIRbtM1MgugS6aC8xrsw+3U90twYPCSiqj6Vv/V2vMWcZUB4iTIWKvAPIphPMDHMLbwzWPb5wMLd9O+GIYX/WWeutarSemvYYT/DqesGRNq3tPRN4OWvb7XJlSMTV5U0suY/gtKhljtWW6W+okK4GVVp8Aswk2F1CnQNDIMABGgHlLeUDhTncdNaz9FpXZfe0edAmXL9oBYzUaqKC
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8676002)(4326008)(91956017)(76116006)(66556008)(66476007)(122000001)(66446008)(66946007)(64756008)(33656002)(54906003)(6506007)(316002)(6916009)(71200400001)(6512007)(26005)(38100700002)(53546011)(38070700005)(86362001)(508600001)(6486002)(8936002)(83380400001)(2906002)(2616005)(5660300002)(186003)(36756003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nkTDUjW4JL37Aq/vWUP8YrAwaOMiP2+uqWn6GQvkzA/2My/EJpFZpAuYr0r3?=
 =?us-ascii?Q?h65lgH+2lOcBg++7jzKY93gdPHXqsJfShP1dCxRLZC7nUp2MEA/9v7VBtIX9?=
 =?us-ascii?Q?OTR5HzJaySHTYRP2ucGLkM54ywImM99fKl1l+nrO+uatUMx9RKMtTPQoU3Gq?=
 =?us-ascii?Q?kmjczHmHyzm+vslUq607Mmf8hg4Q3Ej1b8BCPAzdp3yePOklLf+SnCHc/jAU?=
 =?us-ascii?Q?khit5MLJC9IxdT+cJfxxXnB95ma84Xymd1EOWzFBWkk9k2Q/H7XHHDkwLDuA?=
 =?us-ascii?Q?Fq2icDufHrhilDp7ZY5UOjF0kv/3RzPgpvtrJpOvqm0Hwe28eCYbNummSxy0?=
 =?us-ascii?Q?ovLKCm5JvivB+l1ZWTYMuAKDI4UbU+H1GZ3YGnyDpoAyLri8te1O81wQdw/Y?=
 =?us-ascii?Q?/ute0r9iTtEv19kIIPMq0h8tdvu2Iah5vdjeDQ77S36Aklkuhw7MP56/LSia?=
 =?us-ascii?Q?2mPKZAKqGAwRWJPO386aIjpSzoNgxfLkCdF9+AykgJ2bOEteZl0weoUJ7apV?=
 =?us-ascii?Q?AunfhWR25HHcqBSc+50YpzbCTVrA+gGsvMGUhQnAqNqBeZW1yt5FIieQdJcQ?=
 =?us-ascii?Q?E5qRHR4jaqCXob8R5mnapaL/BbBu7I+Q+g9aw1lgmc8kGJxA/ybdpPTf9857?=
 =?us-ascii?Q?aycuiJPUO2oE/6YlzjCvvN9ageiJJassSroxsBTQUs9/0C/q89HWsEPC2CPC?=
 =?us-ascii?Q?wUGqQVefk+p8RzLOBTDb6r2Xra/dG27FsL0VoU8HE1uMhFa2PpF7RE9XbzxM?=
 =?us-ascii?Q?lp7gVIqWptkyZi2HXSpF0OKCj3/sqCV9PR2VwIwpFYCckU5yQ5RtvgJE6bqR?=
 =?us-ascii?Q?V0sKsP06UBQA2odnUBTyRzZSACk3yDuUpjFqrcgRvUUwFJXIMKStX3T4y4J/?=
 =?us-ascii?Q?iNL37SrQXFAXwyhQGqNP7pst+8O6JPPhZTJ8gcObviiC7quL9utOzrTYAB8J?=
 =?us-ascii?Q?gxVHfhFl0ebPDogrfnOrbouAEIcIDYHwE1gzsZlcGKN1h6hsnwOCjW7R926q?=
 =?us-ascii?Q?NzIbqRx00NjQSfBSCJiCzAFRmuOl6rtkQEcJv8tiNFbEfRUrXf+CsUiN3QEf?=
 =?us-ascii?Q?gbF+VVbY1l52vOfvJtZ69cZWVdF0rSW42xPg45n4UrzQ4GThqIoIPhASE6rK?=
 =?us-ascii?Q?BQyo8fd0/Q44u7FDZNljSTXPI5oNKsVdwgFnbgn/mZO4fA3TcCT4pNPBnmPu?=
 =?us-ascii?Q?LQDRnSbEUX0djo++FgOWM3NKr57Ez1jTNBeWDU8Y9rDGEoW/XlFEv2oC7ecY?=
 =?us-ascii?Q?7jHsIkAjxsOfIO3CaM8g2KVomfC4465Gq/+/S82MaRdG6lZi8sn3GmaYu0Df?=
 =?us-ascii?Q?UO3JomzAeRN5fJf6GwF6irHKW6UTDCNlcl86hE5YmC4Aeo9BBDhhRqMI0tDK?=
 =?us-ascii?Q?DWArzIieELLeExg+EgeI7OdaC9BjjDMywGEvMNqAt8OShg5iIWpmikTe7Ieb?=
 =?us-ascii?Q?eoX+J4wefgCSYMvJ2zXS+r3bU0EvcvqlmoAiYeE4412fWqNHzFxorfd72DOK?=
 =?us-ascii?Q?H55HoRxhAwX7SL0GQZrenkYbnI8raeaacvwoIwKKgtR9uyKDpTcTfyk8yQwy?=
 =?us-ascii?Q?YZmNb6WY77qSCQvurXSV10ibMxbkar/qdonvFBhewQhwPLcHiUatHFC0x+wx?=
 =?us-ascii?Q?31i3HZ7QJ9CEdZy5dBL9Jjc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C06DF151821E9548BD143475BA286299@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b849ea8-5545-44e4-f3a7-08d9f223d441
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Feb 2022 14:43:14.7880
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EmZ7AXVhcRhD4IwDfAN4g00rhJMv/AmCgol/D5PNKlwhnI9lRYKQU3H/a3xzXpX/eUYS3H2jdDbyujsr526QKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB3798
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10260 signatures=675971
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 adultscore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202170067
X-Proofpoint-ORIG-GUID: 9OyAm_GKg7sR2F0ciz1UegbSnFGa_ePj
X-Proofpoint-GUID: 9OyAm_GKg7sR2F0ciz1UegbSnFGa_ePj
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Feb 16, 2022, at 3:44 PM, Benjamin Coddington <bcodding@redhat.com> wr=
ote:
>=20
> On 16 Feb 2022, at 14:35, Chuck Lever III wrote:
>=20
>> On Feb 16, 2022, at 2:01 PM, Benjamin Coddington <bcodding@redhat.com> w=
rote:
>>> Coming back to this.. so it seems at least part of our disagreement abo=
ut
>>> the name had to do with a misunderstanding of what the tool did.
>>=20
>> I understand what your implementation does. I don't
>> understand why it works that way.
>>=20
>> The disagreement is that I feel like you're trying to
>> abstract the operation of this little tool in ways that
>> no-one asked for. It's purpose is very narrow and
>> completely related to the NFSv4 client ID.
>>=20
>>=20
>>> Just to finally clear the air about it: the tool does not write to sysf=
s, it
>>> doesn't try to modify the client in any way.  I'm going to leave it up =
to
>>> the distros.
>>=20
>> Seems to me that the distros care only about where the
>> persistence file is located. I can't see a problem with
>> Neil's suggestion that the tool also write into sysfs.
>> The location of the sysfs API is invariant; there should
>> be no need to configure it or expose it.
>>=20
>> Can you give a reason why the tool should /not/ write
>> into sysfs?
>=20
> So that there is a division of work.  Systemd-udevd handles the event and
> sets the attribute, not the tool.  Systemd-udevd is already set up to hav=
e
> the appropriate selinux contexts and rights to make these changes.
> Systemd-udevd's logging can clearly show the action and result instead
> of it being hidden away inside this tool.  Systemd-udevd doesn't expect
> programs to make the changes, its designed around the idea that programs
> provide information and it makes the changes.
>=20
> You can see how many issues we got into by imagining what would happen if
> users ran this tool.  If the tool doesn't modify the client, that's one l=
ess
> worry we have upstream, its the distro's problem.
>=20
> If the tool writes to sysfs, then someone executing it manually can chang=
e
> the client's id with a live mount.  That's bad.  That's less likely to
> happen if its all tucked away in a udev rule.  I know the counter-argueme=
nt
> "you can write to sysfs yourself", but I still think its better this way.
>=20
> There's increased flexibility and utility - if an expert sysadmin wants t=
o
> distinguish groups of clients, they can customize their udev rule to add
> custom strings to the uniquifier using the many additional points of data
> available in udev rules.

I was not aware of the SELinux requirement and the particular
interactions the tool would have with systemd. Thanks for
explaining!

I think a "set-like" tool would work fine. We have plenty of
those. But I now understand why you designed the tool this way,
so I don't mind either way. The tool's man page, if we proceed
in that direction, should summarize the systemd expectations
(along with a SEE ALSO citation).


--
Chuck Lever




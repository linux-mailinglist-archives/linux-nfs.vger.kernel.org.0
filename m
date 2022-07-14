Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC44B5750E5
	for <lists+linux-nfs@lfdr.de>; Thu, 14 Jul 2022 16:33:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231701AbiGNOdC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 14 Jul 2022 10:33:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231522AbiGNOdA (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 14 Jul 2022 10:33:00 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB70D5C9D1
        for <linux-nfs@vger.kernel.org>; Thu, 14 Jul 2022 07:32:59 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26EDct0n026666;
        Thu, 14 Jul 2022 14:32:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=0gT5N8tFQnC4/3N5WRwCLEwo4xRuUwguXlnrOBuZnMk=;
 b=tHIZdVAnox5yuQdk+eMbSbNS8zu9zVh7rRhNIR5RIclUMQyq9aPS2VxckgxHn2ZarQre
 06TEONvVSVCR+ViA6lmDY5TkGUXn2SDagxOAp17HokD6lYHeu8sVaGHXC6omvXt85i86
 jYk7A0KHdiGVEJm/D1/tS+iz2ACe1LXAUMY46t/M3r9jf4p2HEO8oAOPW0zJoJ2M+7jz
 qoqhuRRjq40flKMvpACzjFRk5A+JQntTdoLCBAO3zz9c4E8YyEgQ7GxWlcmjEfYkpMCP
 qj8fAGipZiFjsYdDLhn3s1jPVykwSVAJe34jKRwcxdUb3Fvai4Ck7zIzerLxK9HA37cA 1w== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h71r1cvnk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Jul 2022 14:32:44 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 26EEBf9E039178;
        Thu, 14 Jul 2022 14:32:43 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3h7046bq05-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Jul 2022 14:32:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WSgmW203cH40KZh8TguGhzPcsUTu9ovl4IVGWqrJ7N0juQf84Qh8Saof8Vrg43e3b84oHRd1wAd/UrfHNyF4PG8eh7srXIPCuAnOnNIVOXINItTPfQ+QDt8u1e7D70TLMY/ioR11xrRKQe0LIM2Mr99z++GABMMRnCQoPAYb6o1yEzrMhqXhXZct0eX6l4arfv3Eo90+vvQHV4T5soaQEfdR5GBewrWkgs/Y2VniGpPSwYhsQGM/SpEUhHq2Wz0oeCI+DUf9Pg4JI1lroWP9/pApXB6oEmYdSn4F7VYDxwroOjK5o5UiEFmpqkHtrjJPpmWsR8GpywivnxeLD2ZnMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0gT5N8tFQnC4/3N5WRwCLEwo4xRuUwguXlnrOBuZnMk=;
 b=FmckT73oyd+t6qvOCPv9B/oH38+H3EoJeukgwAPtBcHqkMFQDEdHgwHxFnZZ5AGUTgXtARUvau1C8fBdiJ0bxeqGmtktdYe4osJKGykByyzPND/fGHekfX5ronE4Nznf63UvEknPpbEViKHhzTRMCnCoPQrHTUE07eb/bkwre3dH5p5nYodhTMqx9YbGxghysskb892TreK7+X1L6MWBw8qbTmuzKwm8aGK/r/mI/Dv9KR+Zko2X496ORMkxw0lEfWA5RFJ766F6SEiWpDF5tydHOSh046v3ri1DKZfTkroJDqyOEPJgiroWuT64Jsy3/XmIOMYIK7272CAsPeuKwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0gT5N8tFQnC4/3N5WRwCLEwo4xRuUwguXlnrOBuZnMk=;
 b=gF4qOL8Q7t0LlE7RxQ0Xn1ATRqQ4VPMmAq9kcpfmUiiBnNBwpDBBS6UfAVs1U9EtJsConEabCHKBFm6m2kAPAvma8/X3VXClrRn7Ejg3EQMocHtVbTmSNqPPmvmoAPKSjD8KWAas1QPqoTs/6YAbmFYb+x7gcaY5BbTqKcPMQTg=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BN7PR10MB2548.namprd10.prod.outlook.com (2603:10b6:406:c9::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.12; Thu, 14 Jul
 2022 14:32:41 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::8cc6:21c7:b3e7:5da6]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::8cc6:21c7:b3e7:5da6%7]) with mapi id 15.20.5438.015; Thu, 14 Jul 2022
 14:32:41 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Neil Brown <neilb@suse.de>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 0/8] NFSD: clean up locking.
Thread-Topic: [PATCH 0/8] NFSD: clean up locking.
Thread-Index: AQHYkO+nUhzdndZueEy9RTo7pT1nKa1xiSYAgAiEbACAAMTsgIAA7tMAgACi9ACAAFMNgIABQ/IA
Date:   Thu, 14 Jul 2022 14:32:41 +0000
Message-ID: <4644E5BF-9365-491E-BB17-507E77E9AA5E@oracle.com>
References: <165708033167.1940.3364591321728458949.stgit@noble.brown>
 <3FF88D5A-9DBF-4115-A31C-6C6A888F272F@oracle.com>
 <165759318889.25184.8939985512802350340@noble.neil.brown.name>
 <3C945625-ED72-4CC1-9CC0-F354FEF0C2E4@oracle.com>
 <165768676476.25184.1334928545636067316@noble.neil.brown.name>
 <13CEFBB0-45FB-4051-8F69-B41DC40CBD52@oracle.com>
 <305c28b90f4d51dac01456cbb383c95999ef5f65.camel@kernel.org>
In-Reply-To: <305c28b90f4d51dac01456cbb383c95999ef5f65.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.100.31)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 522c74da-665a-4428-3f82-08da65a5b56f
x-ms-traffictypediagnostic: BN7PR10MB2548:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nuBEcN+1AQ3JPN4ShEy5mXovvRGl/UlUHJSyLqgipGFrZFAW/UahA/Fel+50FjixVtF80sxsqbcymy6BMxz/sT2MgflGYhKFSOQnJ8l87LFpxaib72OzURS8IBuflOpPH0o2xxCanX/Xf4ASaiZAAC0quqWyeHNXnnpCMm0fJbWu9+4QhWNtvZ73cpiSaQOZLRo4zDXUavjbWPTC/3e7Stdh3n0Ufk9YsBvR5fzfM/DXztkV9RkprNAnQVJRBYXDf9dKjOAFULuuTUNBb/BSaEMY3UaRKpZ9Iq5G4eYNEAGi4AcKedenBeITbk2U5mKlkbelCnZpHMD6vJgXIKCUqCCkc8nK6RQwnp0BU7GxD70tSS7uRJUNb0Y12QyRvWHs1h/Kb19Ywu3d0ONYonmLU9uo58TfET9mpOYx9viaz0WctfydG7DcrfZ0i1Wd0poAZCMve28bkxu7ZJY2uMs7xxneYhnedD3JBAyNolNtK6S4hczda2ORRL5AM1uEG3p2iadEPMTF1L89iFP6TZNM3ARx43mB/o/q4GViPJ+CPXnt5FUH/BZLyEdciUfe0bfjwNftg/ZUHHlnQqG7HQjJnjlCAwSWHcIn83wPgLO0OqA4llB5lpfo9Z+r5oEpXz9F6XL9UCuanmOw4/BqTDzG9M2kRStqWaor7G0a8X/n98euKKkxiA5wZp6PkioA3EYeTBtu2zHmXOaHFYm/qcI5oKuFqi8ieOobTiHbdEGmibe8SB3F5BGGeifwkeIv0wATrOhoRogcxhnYHIdXNmiruKq2Wya8gyHFClOpyKXsRTROXp2mcBRIn8jZ3vwAxEsqNZAFcUMO6wrbzocVgoiDnXBkgnLb5QVR98OW1fUxFVM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(376002)(136003)(366004)(39860400002)(396003)(6486002)(38070700005)(6506007)(478600001)(186003)(38100700002)(6512007)(91956017)(26005)(76116006)(6916009)(316002)(86362001)(53546011)(54906003)(71200400001)(4326008)(66946007)(8936002)(2616005)(5660300002)(66476007)(8676002)(66556008)(66446008)(41300700001)(33656002)(36756003)(83380400001)(122000001)(64756008)(2906002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gz8qNNUlJOp0Z/slvmjiHGgUsZLjwyzaTBhzyBlkfYmfborKNdspKOEHECN/?=
 =?us-ascii?Q?khqDy6sOZO3I3BujLz6PJ/CHZQSE7lvIcsxC3ovOZN9Pj+g/tnTwSJIelCHb?=
 =?us-ascii?Q?VydDSgUUARg61FmroqckOEbQSC4rBlJSyzaGPNJQaYj4Msy6E8VA5UVJRGLH?=
 =?us-ascii?Q?QxPS5afjyJ8XxT59LzwLea8kmrsRW0kfQ8cKnWTlWZoWJNtHhLShNCtd2gEi?=
 =?us-ascii?Q?UdZjOGSx6wAbuPVruOPBG+H5uWCI79udGR8Liuo5/koeBZxkcZxm5Zsg5w7U?=
 =?us-ascii?Q?KIEcHH5dEHFoLQ8MiOHP64LSKsaWwUQsrwdLU0aUcpZdbeIrMXagq1LVnQF/?=
 =?us-ascii?Q?5MVCa/zsdeo3MLNadZZn4SCyI0k/+2Mf4aMmpdLvyFj7TP2k3FJhJ6tcQkXc?=
 =?us-ascii?Q?E+l12yT+6yn2NpM22m1zZcbzVTdiVovzSzWgWMA56sf6bqqrxiy+p6ASIE+f?=
 =?us-ascii?Q?yB0Oe80vuIdC7EDPzGh3tdVNDz7vAcJjJ08j8hIQfL625GYf2AtTXI0jAoaT?=
 =?us-ascii?Q?St/GQB9nim8oSG0DkRQvld1747NqWGDhq5iHOnGGh8Bnd2cl5pSsHvQQM21D?=
 =?us-ascii?Q?wH0OQGrz42fxtFoAydm5Pu2zFtalb3B+fCJMZQeSOqKThBv3Dm78GtKlExhR?=
 =?us-ascii?Q?JT8PTNfbmSmb1bCw7fTQliVPIo8AFv+6VyRmFH7eNWdM78tDFXPYhdUiVWu6?=
 =?us-ascii?Q?JciZs1L6beorYqogqNIUqoBT9wVQ+/5T5xV3eMWiocTjcljad7fRU+ppiyfR?=
 =?us-ascii?Q?MtU+1b7uqBlDhGD/39oZJ9z6WOOiFqa9qtpP4QHXMsDO0QHzs0x5wE6RJZTT?=
 =?us-ascii?Q?gsrpGecRRP5Ined7Wq8VEv+xQjmrCJpoKwIX/NWtCEM2cOUlwSQQKv5kKFyz?=
 =?us-ascii?Q?I7yviIyMSiOnapkRz6hHbbPkqCFfPgN2NZshaExRimp1VrQm+OFHk79pHzPb?=
 =?us-ascii?Q?GYpUSGJyrzdSKGB5T81rDHbdZQklhbLkg6hrFINaCv6PN7tEz5AYh7gP49iO?=
 =?us-ascii?Q?0dFDY4RGlkQSFuk70mRo6/PP+gyTzTNnyNmyBvgZZvAAYQGqfy+V86te533c?=
 =?us-ascii?Q?gQjBhcWwc9GU+VgiAOZN2XrRYp/0DwRYguE0nWv3mmUVig6VH+mKlx3/Cj/b?=
 =?us-ascii?Q?+tU/YdYGBPWeI7vi+DMep9qmvIq9iGkMxdQJseUibIKpyjZJ8VqcmKEYq3rX?=
 =?us-ascii?Q?OodJp9wZbK7e1EFXqQRmNV0haFdADQRe2qhpuHu5gfHWxUaKc7GHEIgsMp14?=
 =?us-ascii?Q?GTqxCs+QbGapTqaR3z1B2/0gRWT6XS2u2VzHzRFfkSJ8v7x1gVx/k+K+n2BB?=
 =?us-ascii?Q?ae9Z9EXwzlC44OkgJEy5aIEir0pfBBAHoC7HTU/2JD94smv7Mr4grHV90nvb?=
 =?us-ascii?Q?SWApTzGrMpFZonCKd2hDIIXZnqj2TebXgxhwuM98neOXrSrbXNBMdcPCgs++?=
 =?us-ascii?Q?WcgiEhQAJCLP/B2zumQpB7atvUFLdzwFVO5jkDynQjqgaRzXpqJ6JCWg+MGR?=
 =?us-ascii?Q?vNTZBZlalOES9/4RK/ygoWWGssxdM1ov68RXwXO8Hp8BfLuowc0uLGwWOvIH?=
 =?us-ascii?Q?pC3l4gC7xv9q3sN1Y1AGYOzjGNdRSDpv0NU2bC//ndE9D6FbH0o8A/fxezXC?=
 =?us-ascii?Q?wQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <42FC0A40055F3644B9380027DF43FC3E@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 522c74da-665a-4428-3f82-08da65a5b56f
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2022 14:32:41.4010
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LM2dAf/h/lPyiXy1pTB5rz4bH3k0CKdjNU/tWV1i4EiFqKj4wpSs5hH3s3gC4beRx+/aTblzn47YyjC35hhojw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR10MB2548
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-14_10:2022-07-14,2022-07-14 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 spamscore=0
 adultscore=0 suspectscore=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207140061
X-Proofpoint-ORIG-GUID: Tw7zBCb74lEjvcy1wvFFD4ng5DBin0Ah
X-Proofpoint-GUID: Tw7zBCb74lEjvcy1wvFFD4ng5DBin0Ah
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


> On Jul 13, 2022, at 3:13 PM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> On Wed, 2022-07-13 at 14:15 +0000, Chuck Lever III wrote:
>>=20
>>=20
>> Just to be clear, I'm referring to this issue:
>>=20
>>>> NOTE: when nfsd4_open() creates a file, the directory does *NOT* remai=
n
>>>> locked and never has. So it is possible (though unlikely) for the
>>>> newly created file to be renamed before a delegation is handed out,
>>>> and that would be bad. This patch does *NOT* fix that, but *DOES*
>>>> take the directory lock immediately after creating the file, which
>>>> reduces the size of the window and ensure that the lock is held
>>>> consistently. More work is needed to guarantee no rename happens
>>>> before the delegation.
>>>=20
>>> Interesting. Maybe after taking the lock, we could re-vet the dentry vs=
.
>>> the info in the OPEN request? That way, we'd presumably know that the
>>> above race didn't occur.
>=20
> I usually like to see bugfixes first too, but I haven't heard of anyone
> ever hitting this problem in the field. We've lived with this bug for a
> long time, so I don't see a problem with cleaning up the locking first
> and then fixing this on top of that.
>=20
> That said, if we're concerned about it, we could just add an extra check
> to nfs4_set_delegation. Basically, take parent mutex, set the
> delegation, walk the inode->i_dentry list and vet that one of them
> matches the OPEN args. That change probably wouldn't be too invasive and
> should be backportable, but it means taking that mutex twice.
>=20
> The alternate idea would be to try to set the delegation a lot earlier,
> while we still hold the parent mutex for the open. That makes the
> cleanup trickier, but is potentially more efficient. I think it'd be=20
> simpler to implement this on top of Neil's patchset since it simplifies
> the locking. Backporting that by itself is probably going to be painful
> though.
>=20
> What should we aim for here?

If there is consensus that a fix for a possible delegation/rename race is
not necessary in stable kernels, then there is a little more maneuverabilit=
y --
we can shoot for what is ideal moving forward.

Again, my main concerns are not perturbing the legacy code if we don't have
to, and having the NFSv4 code spell out its locking requirements clearly.
After that, performance is important, so avoiding taking locks and mutexes
(mutices?) unnecessarily would be best.


--
Chuck Lever




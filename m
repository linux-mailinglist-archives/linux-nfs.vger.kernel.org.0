Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10F8F5813BF
	for <lists+linux-nfs@lfdr.de>; Tue, 26 Jul 2022 15:02:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233180AbiGZNCb (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 26 Jul 2022 09:02:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233364AbiGZNCa (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 26 Jul 2022 09:02:30 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB3E51BEA0
        for <linux-nfs@vger.kernel.org>; Tue, 26 Jul 2022 06:02:27 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26QC3wub022540;
        Tue, 26 Jul 2022 13:02:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=+SbuC/n8nTCW41lYUy3ooUPj3gMS6cZw1Bg5htKgwbA=;
 b=vEm/XboC7W1GE9ofB4aCDYEGm4Ecp6XDoXLwfxwJIHOQIs4LH/puxLPYzx2D/MEPo2QE
 pBya4aBJPJhjPmMKEnCV/EDCVuRTNpa9oqbdwxyvvndlGorGy++kC0XzQzonSu4dsIho
 JvRRsO2kKl7jhUJfmsO/2eT2P5qlzz/n69sSuDkT9NOPuP5TJhBU4nIWb1WGV/bPl9S7
 6T3oA/nCLgBjFxJO6k4CMqpQ+QtDWqLQinDqLVTisX0jjBqjt5/mtcb0Q+LG3OEcu8lt
 jdBYGq+KZ1Rje+5erlxAzh2cf9oohaGq8GfVNV1QqvvtNU3HGVRYgSJVes/qorcBZnea Wg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hg9a4pehe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Jul 2022 13:02:14 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26QC8BhW019875;
        Tue, 26 Jul 2022 13:02:13 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hh637r4d4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Jul 2022 13:02:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DZ+bVQaL3DNHHHcSABdz1i1Y/RW+gbQlpUkZhvp3nPLDaPmdEKwpvpLG6BBED9VzmpCm7caP70xqWfeZoAOXM/zkYEcZEyWyLhLUo1oNr2fCKuizlyY/+kkR2Z1H9GCBpG4uA2N70uw+mBBJCezKROssrSgqj+AtIsAMupyhgC+Msxr94KV+Pgj6kg3AGhudBZtAXD+AW7OmMY3COoZukhR5w0vVgRq+p3Cu5BLohJ25n4ZcHOaGaqBA5i9L/atNHO2Gs0U5539QzgXwE6DqHLBxgVBwLrj2oiE0ItM16o31I/em8lU9Ze3RwMw3mZGlm0JovYmhllmTFdM/Qy6nrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+SbuC/n8nTCW41lYUy3ooUPj3gMS6cZw1Bg5htKgwbA=;
 b=RnQnVhd8HmKivsJ1NQTKATzdhfUOLkRjrokEfZL2qKbcoyy9a/iOcfJQczJywckCTOCvsCEK0fyG3aAeFrdJt0kAaH4NQrRu+xF5KmH7cKzqvU6rx1Vbx6FGRPO/uY7f+fHweBH5exnQLMJZOsd+m2K4apYnDkJ30uoubl4hjuPzq/aSyaJDmP9yWuS3U4otMcbs+5ghHFja0tlazGGmsVZue31K/zedBRQcr8d//AcTC+saV0zygLa5nGL3oDTXSCalSBv+z691WimWJNrue/+iTcilr5twD+u7oF6usHgYS+l1KJBEicpagXwyXrX2CdX1iooAbZj9VBfD5+tEzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+SbuC/n8nTCW41lYUy3ooUPj3gMS6cZw1Bg5htKgwbA=;
 b=djQ7PxDU3jyB+WKmu3pmvnHQyCfRix4m3MQNWiRHlCJYWKxgk35NRQAVXV1CivBZ3L/z4ZbfVPvxi7YXG7XMAcxPJ9L1nSPNCZySjRrn0zW9xaRWKAgXoG72B2r6A96J+rivqfXp8tMKCjMtJW8oGhBzLROkclR0DPnlgKni5Nc=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MN2PR10MB3997.namprd10.prod.outlook.com (2603:10b6:208:1ba::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Tue, 26 Jul
 2022 13:02:11 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::8cc6:21c7:b3e7:5da6]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::8cc6:21c7:b3e7:5da6%8]) with mapi id 15.20.5458.025; Tue, 26 Jul 2022
 13:02:11 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Neil Brown <neilb@suse.de>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 04/13] NFSD: set attributes when creating symlinks
Thread-Topic: [PATCH 04/13] NFSD: set attributes when creating symlinks
Thread-Index: AQHYoLujfmoC23Q2SEegG+eOkJm9Ja2QmDgAgAAD3ICAAAJJAA==
Date:   Tue, 26 Jul 2022 13:02:11 +0000
Message-ID: <CBD496D1-BC30-445E-961A-44C1BBCDFF98@oracle.com>
References: <165881740958.21666.5904057696047278505.stgit@noble.brown>
 <165881793056.21666.12904500892707412393.stgit@noble.brown>
 <A4671B71-ECAD-42BF-8B67-5C098FF36172@oracle.com>
 <b7a9931ade91a2f516be4c8fb6104f7aa733d878.camel@kernel.org>
In-Reply-To: <b7a9931ade91a2f516be4c8fb6104f7aa733d878.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 51c527be-dd88-4989-224e-08da6f070dc9
x-ms-traffictypediagnostic: MN2PR10MB3997:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pH2wkdIBocKbQYkqPZMEo6nLfGezgWlilsOx7qkoDeleVT6i+JqANd8Yw8nCLFRvSU3m4UrLRfPXhC7pwI2Ewkqcz9XLQydMr3nq9PAe8gXpzc1M8lToH8Ys0qH+tLxhGFHGCpau5dSMXDYazLu6egE+ZvSdyFOVHRBsctsDB1xGBctYOCzuhj8677TIwdhflLBCOpdZ7PImYBJ+oIkMkp6nHPTvyW6U3PEjGWVOLKAOWVSWtcJ2SGDwjLW5g1wKgBJRVuAExC7IQhYNx1vghRqTyf7DIJCYDytP14xmrIPiWH7XQO67u141HXRgvAqSd3wkvI7WLgP1wvRnl9GBAMYFQf8ahH9i7WnVZs7MpBxhGInnZZU4Y+rJLiv6R1e00+ZvYCzYJSr/uPhX4FXYmkKqPkIOQPfLjWQsRVEKE/vll/vsEqDhnPpIm8yvxvNYo27jCJVMCXBCxvjdDMQgOXtlWn26GLGTtIybrZqnAonanyww7Hv9CLaT706yK03b9G6YE8EJNwBn7ZN/w0MAUbjg13XU9a3bMWMZgdfE4W5K9a3cM6pb4xM+uiQk5ZN3IOKSswenrZiwOhr5omwYHf+/8J5Jcrqk8S3aprzCx1fxEfIpExMmxiVkkeZV7vnl/kgl3k4BnlKA/taWuquMK3E2hmhUMGreKgXUEs1v9xMXWRfMxH26sjp1/RX/QAcuY0cLx61CoyWCvygfzw8Rkp+xEft8oFIEU91WFCAgXHRA6vZcy7UrIMSm3HAR7BOtGnMQOCy4tN8CDbDV4gfVLazowOtYFhZ+DqlGMCpEgwOQFt4bCnbi4uy8IAyOzlHV4j4+X50eY4w5N+4gkG0kYA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(136003)(376002)(396003)(346002)(366004)(2616005)(53546011)(71200400001)(76116006)(64756008)(122000001)(2906002)(66946007)(66556008)(91956017)(66476007)(66446008)(6512007)(83380400001)(33656002)(8676002)(86362001)(38100700002)(4326008)(54906003)(6916009)(186003)(38070700005)(478600001)(8936002)(5660300002)(36756003)(316002)(6506007)(41300700001)(6486002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?AIDqNkyMLbn2m9ZOyKdc5uuGecpWNmOtrfRdCL5GgkJQ72cw0TJhBozpTnKe?=
 =?us-ascii?Q?zWxeUVJ40Yxvj25TK0TugSZXftGBYvr3RxIM4zueSjo8DYT7zRd26/YvHEDe?=
 =?us-ascii?Q?hsopVOixI1GuIVrqC1ZubNN0UbtvLASmTrV69PSZDoq49BdZa1qlOLqqnZNy?=
 =?us-ascii?Q?ZeitC5EkZefkzcd4l5bio1yT2jtym5p9FDSl3x1why9lc71IJ6Efe/+HSoy4?=
 =?us-ascii?Q?G1IzQxNITXIRnRP2EncJn28JLA/T18usfLCnZOgPxQmauxSrMPn+8xV/gLQf?=
 =?us-ascii?Q?88ESvWriw0xeojhSyOjApZjgvQTxwZviJbddzJzso8+B11DoAcDgnrsZBcYw?=
 =?us-ascii?Q?d0UqFCt5j5kc4synCV0D1sRo5h2RzmqCJSO42sH8u6f8P71guFlf2T13Dn5L?=
 =?us-ascii?Q?3Nhw+sKXsQ6hQyFjxX7MacR9/H0itgU+YjVzwsVl4cjedzYHGGSWYuftaGhy?=
 =?us-ascii?Q?afsI0QXgNntf4DRqduKT92E3/E/EleRkcBXgqGmzypcIrm7EVgQy5pO9OmkP?=
 =?us-ascii?Q?2VNAZoIklhJzIsHXyXLZ4/pwQmJgPwUs8WcLxkwjcHNG2rTrfrdefaoGRcOC?=
 =?us-ascii?Q?DB4xiheuKPu3sBDKvhhfq1WGi1au38Us5Jid/l3SD+K2Pr98Z1c9vDFF8GBU?=
 =?us-ascii?Q?lzuSE6Bhq0ye948FG/GDdW3M7TypXA7u6nxuf5QvYPg/NvSXZ5a6a9DaeIPU?=
 =?us-ascii?Q?Q0sOUtTrq4+fY6Z/du1f01Qcd2UVgyg33eL0rW07tcir69fC5pbxqnu/jdUm?=
 =?us-ascii?Q?6s3A7PcN/uHoLgagIssX3MHXd0+ZbQ+aQPATRzz2qnZldgdhrujR2F2T4vJg?=
 =?us-ascii?Q?MsvRme1wSElaYWTaRZrlHgBuD4/ZTdDHGQeWCbkrXZraG/ujpijo3aHshwkf?=
 =?us-ascii?Q?O7m+AJ+gWmszx8NzBDBPFyuKDY4NjO3VbjA/lZ4m/Oi3ajfCo9sGd3W020f1?=
 =?us-ascii?Q?DOMeUD3rze/sb/WJFYOi0t78Q3JsRmpfap8nI7IKgYU+9pTA5PtEWrrCrFzB?=
 =?us-ascii?Q?I4S4CRmJuSDZdtWI4kzJDVXdSxICC1G2xQe0krboPWt/PT9BJseW85q4/PeX?=
 =?us-ascii?Q?iPjxpqpVWr9A5r/PIpqoxVZ2nFrDD3N2NGeynOE5oZNecPyaNoU5IWKzFTMo?=
 =?us-ascii?Q?Ag6T+/uCaqfiDntHilTLY3G5vAHXVylvZBEbsKtFB0yiPDV0oY9TbATRozZ4?=
 =?us-ascii?Q?EqKUPKnILP4clq7xBOo6FqLpHvqEmTYt3MvEuF8//WS0cwmWHEweJjh7vrlq?=
 =?us-ascii?Q?SOwKPYbynwMWlCholwUDVDenxz3xgObZJS8zQjnuXsGyfJlJXBkfJJZI5Q68?=
 =?us-ascii?Q?nhIJluvbl1Aq9ysQIguDPAEXsdekPl+a0PhrY5dWgu/kZCEmPQYVBuMWFLja?=
 =?us-ascii?Q?D1cGldWudUxvLSV9Xr0M2kfgDTaDrgmam8tw22N+splGJOXGjyAOvxv7rZat?=
 =?us-ascii?Q?0WBunOWUBjW/fVgv+XCckRoOvw5GA9A3IPilRroeGpD8N28V/gdSveJCRub2?=
 =?us-ascii?Q?6FjKtXDWm2vJ085LsBLWWqiijyEHvbURMS0XsEd21ZTkqInbal3dF2Yy7zJ0?=
 =?us-ascii?Q?u+iwQWUMw3GWYRIyMeks5qWfbCHveun56cpv3uU4gmmgZsfdyj62HN/IFVgg?=
 =?us-ascii?Q?eNWPX1soZxwxbz0e+AcPwzDPWDFlJzdHG1em/AozZgCPDN5YHQy7dI8JZt1J?=
 =?us-ascii?Q?w5vYsw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <DAD6F28F18E3F943A9325AEA5B15CB16@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51c527be-dd88-4989-224e-08da6f070dc9
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2022 13:02:11.2617
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h37pBLXPW99QPc9+lJBJdFkmiu/knA1v4RqqiiizHCJsfvCJD+7uLbOGeohsUMkgqte4+Oqt5/baNFDtqI8yHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3997
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-26_04,2022-07-26_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 suspectscore=0 mlxscore=0 bulkscore=0 adultscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207260049
X-Proofpoint-ORIG-GUID: HKFXKacrNT_sUT1IUL6c04UW2J4r66Qy
X-Proofpoint-GUID: HKFXKacrNT_sUT1IUL6c04UW2J4r66Qy
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jul 26, 2022, at 8:53 AM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> On Tue, 2022-07-26 at 12:40 +0000, Chuck Lever III wrote:
>>=20
>>> On Jul 26, 2022, at 2:45 AM, NeilBrown <neilb@suse.de> wrote:
>>>=20
>>> The NFS protocol includes attributes when creating symlinks.
>>> Linux does store attributes for symlinks and allows them to be set,
>>> though they are not used for permission checking.
>>>=20
>>> NFSD currently doesn't set standard (struct iattr) attributes when
>>> creating symlinks, but for NFSv4 it does set ACLs and security labels.
>>> This is inconsistent.
>>>=20
>>> To improve consistency, pass the provided attributes into nfsd_symlink(=
)
>>> and call nfsd_create_setattr() to set them.
>>>=20
>>> We ignore any error from nfsd_create_setattr().  It isn't really clear
>>> what should be done if a file is successfully created, but the
>>> attributes cannot be set.  NFS doesn't allow partial success to be
>>> reported.  Reporting failure is probably more misleading than reporting
>>> success, so the status is ignored.
>>>=20
>>> Signed-off-by: NeilBrown <neilb@suse.de>
>>=20
>> While I was trying to get more information about how
>> security labels are supposed to be applied to symlinks,
>> Jeff, Bruce, and I had a brief private discussion about
>> it. Jeff has the impression that NFSD should not apply
>> ACLs/security labels to symlinks, and we believe that
>> would be somewhat of a change in behavior.
>>=20
>> Now is a good time to hoist that private discussion to
>> the list, so I'm mentioning it here. I'm thinking it
>> would be appropriate to introduce that change in this
>> series, and probably right here in this patch, if we
>> agree that is the right thing to do going forward.
>>=20
>> Otherwise, after a brief glance at the series, it looks
>> better to me than the previous approach. I will try to
>> dig in later this week so we can get this work merged at
>> the end of the upcoming merge window.
>>=20
>=20
> My take was a bit more nuanced... ;)

I was summarizing. Please feel free to correct me.


> The kernel clearly doesn't do any mode/acl/label enforcement when
> traversing symlinks, but I think we do at least need to allow security
> labels to be set on them. We can set labels on symlinks on local
> filesystems. Installing software in (e.g.) SELinux labeled environments
> might go awry if we don't allow this. It could also make a difference in
> who is allowed to unlink them too.
>=20
> NFSv4 ACLs are more ambiguous. It's probably not terribly harmful to
> allow them to be set on symlinks, but the value of doing so is not
> clear. We could probably just ignore them and no one would care. OTOH,
> maybe DELETE permission actually matters here? Do we enforce that in any
> way today?

Sure -- we can always punt on making behavior changes now,
and simply continue to support what has been supported.
I'm not aware of many regression or functional tests in
this area, so it's going to be difficult to proceed with
modifications that alter behavior.


> These might be good questions to take to the IETF list...

Agreed. I made some informal inquiries to a few folks directly,
but asking publicly wouldn't hurt. It also wouldn't hurt to
ask implementors of other NFSv4 implementations.


>>> ---
>>> fs/nfsd/nfs3proc.c |    3 ++-
>>> fs/nfsd/nfs4proc.c |    2 +-
>>> fs/nfsd/nfsproc.c  |    3 ++-
>>> fs/nfsd/vfs.c      |   11 ++++++-----
>>> fs/nfsd/vfs.h      |    5 +++--
>>> 5 files changed, 14 insertions(+), 10 deletions(-)
>>>=20
>>> diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
>>> index 289eb844d086..5e369096e42f 100644
>>> --- a/fs/nfsd/nfs3proc.c
>>> +++ b/fs/nfsd/nfs3proc.c
>>> @@ -391,6 +391,7 @@ nfsd3_proc_symlink(struct svc_rqst *rqstp)
>>> {
>>> 	struct nfsd3_symlinkargs *argp =3D rqstp->rq_argp;
>>> 	struct nfsd3_diropres *resp =3D rqstp->rq_resp;
>>> +	struct nfsd_attrs attrs =3D { .iattr =3D &argp->attrs };
>>>=20
>>> 	if (argp->tlen =3D=3D 0) {
>>> 		resp->status =3D nfserr_inval;
>>> @@ -417,7 +418,7 @@ nfsd3_proc_symlink(struct svc_rqst *rqstp)
>>> 	fh_copy(&resp->dirfh, &argp->ffh);
>>> 	fh_init(&resp->fh, NFS3_FHSIZE);
>>> 	resp->status =3D nfsd_symlink(rqstp, &resp->dirfh, argp->fname,
>>> -				    argp->flen, argp->tname, &resp->fh);
>>> +				    argp->flen, argp->tname, &attrs, &resp->fh);
>>> 	kfree(argp->tname);
>>> out:
>>> 	return rpc_success;
>>> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
>>> index ba750d76f515..ee72c94732f0 100644
>>> --- a/fs/nfsd/nfs4proc.c
>>> +++ b/fs/nfsd/nfs4proc.c
>>> @@ -809,7 +809,7 @@ nfsd4_create(struct svc_rqst *rqstp, struct nfsd4_c=
ompound_state *cstate,
>>> 	case NF4LNK:
>>> 		status =3D nfsd_symlink(rqstp, &cstate->current_fh,
>>> 				      create->cr_name, create->cr_namelen,
>>> -				      create->cr_data, &resfh);
>>> +				      create->cr_data, &attrs, &resfh);
>>> 		break;
>>>=20
>>> 	case NF4BLK:
>>> diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
>>> index 594d6f85c89f..d09d516188d2 100644
>>> --- a/fs/nfsd/nfsproc.c
>>> +++ b/fs/nfsd/nfsproc.c
>>> @@ -474,6 +474,7 @@ nfsd_proc_symlink(struct svc_rqst *rqstp)
>>> {
>>> 	struct nfsd_symlinkargs *argp =3D rqstp->rq_argp;
>>> 	struct nfsd_stat *resp =3D rqstp->rq_resp;
>>> +	struct nfsd_attrs attrs =3D { .iattr =3D &argp->attrs };
>>> 	struct svc_fh	newfh;
>>>=20
>>> 	if (argp->tlen > NFS_MAXPATHLEN) {
>>> @@ -495,7 +496,7 @@ nfsd_proc_symlink(struct svc_rqst *rqstp)
>>>=20
>>> 	fh_init(&newfh, NFS_FHSIZE);
>>> 	resp->status =3D nfsd_symlink(rqstp, &argp->ffh, argp->fname, argp->fl=
en,
>>> -				    argp->tname, &newfh);
>>> +				    argp->tname, &attrs, &newfh);
>>>=20
>>> 	kfree(argp->tname);
>>> 	fh_put(&argp->ffh);
>>> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
>>> index a85dc4dd4f3a..91c9ea09f921 100644
>>> --- a/fs/nfsd/vfs.c
>>> +++ b/fs/nfsd/vfs.c
>>> @@ -1451,9 +1451,9 @@ nfsd_readlink(struct svc_rqst *rqstp, struct svc_=
fh *fhp, char *buf, int *lenp)
>>> */
>>> __be32
>>> nfsd_symlink(struct svc_rqst *rqstp, struct svc_fh *fhp,
>>> -				char *fname, int flen,
>>> -				char *path,
>>> -				struct svc_fh *resfhp)
>>> +	     char *fname, int flen,
>>> +	     char *path, struct nfsd_attrs *attrs,
>>> +	     struct svc_fh *resfhp)
>>> {
>>> 	struct dentry	*dentry, *dnew;
>>> 	__be32		err, cerr;
>>> @@ -1483,13 +1483,14 @@ nfsd_symlink(struct svc_rqst *rqstp, struct svc=
_fh *fhp,
>>>=20
>>> 	host_err =3D vfs_symlink(&init_user_ns, d_inode(dentry), dnew, path);
>>> 	err =3D nfserrno(host_err);
>>> +	cerr =3D fh_compose(resfhp, fhp->fh_export, dnew, fhp);
>>> +	if (!err)
>>> +		nfsd_create_setattr(rqstp, fhp, resfhp, attrs);
>>> 	fh_unlock(fhp);
>>> 	if (!err)
>>> 		err =3D nfserrno(commit_metadata(fhp));
>>> -
>>> 	fh_drop_write(fhp);
>>>=20
>>> -	cerr =3D fh_compose(resfhp, fhp->fh_export, dnew, fhp);
>>> 	dput(dnew);
>>> 	if (err=3D=3D0) err =3D cerr;
>>> out:
>>> diff --git a/fs/nfsd/vfs.h b/fs/nfsd/vfs.h
>>> index 9bb0e3957982..f3f43ca3ac6b 100644
>>> --- a/fs/nfsd/vfs.h
>>> +++ b/fs/nfsd/vfs.h
>>> @@ -114,8 +114,9 @@ __be32		nfsd_vfs_write(struct svc_rqst *rqstp, stru=
ct svc_fh *fhp,
>>> __be32		nfsd_readlink(struct svc_rqst *, struct svc_fh *,
>>> 				char *, int *);
>>> __be32		nfsd_symlink(struct svc_rqst *, struct svc_fh *,
>>> -				char *name, int len, char *path,
>>> -				struct svc_fh *res);
>>> +			     char *name, int len, char *path,
>>> +			     struct nfsd_attrs *attrs,
>>> +			     struct svc_fh *res);
>>> __be32		nfsd_link(struct svc_rqst *, struct svc_fh *,
>>> 				char *, int, struct svc_fh *);
>>> ssize_t		nfsd_copy_file_range(struct file *, u64,
>>>=20
>>>=20
>>=20
>> --
>> Chuck Lever
>>=20
>>=20
>>=20
>=20
> --=20
> Jeff Layton <jlayton@kernel.org>

--
Chuck Lever




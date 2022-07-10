Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EDC956D00E
	for <lists+linux-nfs@lfdr.de>; Sun, 10 Jul 2022 18:42:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbiGJQm5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 10 Jul 2022 12:42:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiGJQmz (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 10 Jul 2022 12:42:55 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DB1213E09;
        Sun, 10 Jul 2022 09:42:54 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26AE1vFC001352;
        Sun, 10 Jul 2022 16:42:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=2B9FOV1jIW+6En5H99SGU5bf42UeUQEyW6BSnppEf9c=;
 b=CMmIsr+OAEGoToZDzsAv/sXl1D+EjeL5j5+KPE41Y7u0oJulKgM4XWNTeDJMxf0P/8rq
 +P42a2VkRHODdEvuXUmXkSHNsPy1RQncWpIyz+9xXCTDsknCu1thALjfjSRW/1rwbsb3
 qOlA4YA/nhw+o8lK8UG+OHv0Gh1brxQ2SiFKfUKJx9g+m4hP/VeQqEEeigZWjpnJrUvQ
 aWXltmEexPNah4S3kCRFFMjY6Y1BjhmLZ4jaY9aWte6J29P1I1zwmIYzQHCXJAd+aLlo
 Gj48e7YWQVrjhpgu5E5Du0J1J/J/S6xc+0j/OP29f4eCbqQpJNktAWxgs9eCEmfdJSCX WA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h71rfsq3a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 10 Jul 2022 16:42:47 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 26AGUdUP007393;
        Sun, 10 Jul 2022 16:42:46 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2104.outbound.protection.outlook.com [104.47.55.104])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3h70417u8w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 10 Jul 2022 16:42:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c+a+x8RC1ecw0qcOzJAYG2Ds4lajp+oKXVzbC6xvwDhl3Wl/cmdKk4HbcAG512Htyz6qoyAbWsKsWgNFKw8V8KjhM6Dye4wXIwKCs7RcvudDWAHatFeIAdpUQUvRbCZCgP7sivlHfuOc+gstzJK1NvOtzOPYVhFK9Gpi+vn5CtlkuaaTz+a1ycpVmicx80U4WbDV6/x3ZzO4GcMup+OssegoEhfYWptUO1mkUAeBiJVwHlb3mQ17tln5srDLZXxIeZ0jKROYIrcbK/2cHd+zXpLfSoke2h7lMUyGkJULrDAM8kJZAnLYWWu8EOK70S53zPcwGmm9nbWIwXVRNc++mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2B9FOV1jIW+6En5H99SGU5bf42UeUQEyW6BSnppEf9c=;
 b=H4XLW84dhgB5QcLggzC1UbLIwsKGwmb+CdkNzpIorBRDsj6/tG9gDd2NirvBCYkcBWxb/Cdc2nLHhJh2qUE5WKn+lNzoSZ+D193DPnI/fV5H5TgQGiM/EsQkVsxNeYe9RLo5r3bhiv5eKTkDbOmbwWXWztqek7jxWI6pc29i7PX5PkcNe98I52YdhQrUCb8shnjBYDziUKqPdC+DgRnIp8ydS3gLpZSH3oxABltc6g3XNX2uu53bl+DtBWzU2/fuFYs3R5BsjeGGdmWayWk8+Jlsn7lY+VMlDmkucGkfXoRzdubKOiCv9LJ/L3hfF43O4NTM3QOP5AYP01RFeyZv+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2B9FOV1jIW+6En5H99SGU5bf42UeUQEyW6BSnppEf9c=;
 b=nhKeiuCraN82TpZ3RriB7cUUkLP7DV+B3YRF2jv/Zq4NO1rPQNbxeaHC+LdMGqe6SCHHIqFeEyTAs49ZOggZrPdx82+f8uAHP5LotHHTmzMpkpdb3dRoJuS0r+A9FrDqWuQC+HWgl9C2GQV0A8qs32UVKUFF3IOf9dWXJ1vSpOA=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DM8PR10MB5416.namprd10.prod.outlook.com (2603:10b6:8:3f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.20; Sun, 10 Jul
 2022 16:42:43 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::9920:1ac4:2d14:e703]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::9920:1ac4:2d14:e703%7]) with mapi id 15.20.5417.026; Sun, 10 Jul 2022
 16:42:43 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Igor Mammedov <imammedo@redhat.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Ondrej Valousek <ondrej.valousek.xm@renesas.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bruce Fields <bfields@fieldses.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jeff Layton <jlayton@redhat.com>
Subject: Re: [GIT PULL] nfsd changes for 5.18
Thread-Topic: [GIT PULL] nfsd changes for 5.18
Thread-Index: AQHYPS20r3Ca7pclI0+jw5IFRtIPbK14GX4AgABkTAA=
Date:   Sun, 10 Jul 2022 16:42:43 +0000
Message-ID: <B62B3A57-A8F7-478B-BBAB-785D0C2EE51C@oracle.com>
References: <EF97E1F5-B70F-4F9F-AC6D-7B48336AE3E5@oracle.com>
 <20220710124344.36dfd857@redhat.com>
In-Reply-To: <20220710124344.36dfd857@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.100.31)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 55a3dee6-e604-4003-d7a4-08da629335f2
x-ms-traffictypediagnostic: DM8PR10MB5416:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: m3eSbjNpXAsGYILsZXn2JcRswxQ0AwK/L8/E19OjPuwZKxt1kBjO9m7LxVt6XeVHQ+EtnrHP8uoIWua/qw2Vdi5z+HLfaKHbmQt3z58jjb4AII9v5LpYDaxoxWHWK3R9juJAcR8I5XRUd5kbHIP7+xNO3+hZcqt/qvyKcerDE7EtJGp0VXXMmCO6U249pn2vlFS7cdHlA11GvceAPXPC//U76naydPJLF1GKDqQcZHHan8noEceztM+iJs0u3ScdKkDnN65CNDjqzTAc+hun+nCxpmjChMSWsVkHrQ3kDOf6dcqUWYqbJ5mpFt+JHwBYxhYE1s3QR9x9QXOohDSdYC3krd9WxFM4VnI2om8SAqMdfgzTBnOkui+evo4koPiXYW2FTfgwjI6UQvBefHBU8XF8Oz+GggtlcvIBIetk8cV14j4A5C43Fy2SwHHa3sHgp2R6xo4oDakB/bRGi+f5pATSZxUCUQJxFZQOKNhgVq2VGKISzR6+SUxhpBKjAomqLFZPfJGYyhNj6mYeaHx//qvBP0AQ16t3DH+6XE9WjKl2nActMca/8NElxcXsGy+MMI4e6nme828WqAa68NqHgmOTx2RY4aHQdiPP74rIZZWSpH/DXeuQDBUfhrvx196mWdAPNiPu6IR0x4TC5991kui+jKFnHBRal0YD1m8tgGeolvQdGSLK9BwfouKYx1Uj8tC0man9Hn+aLEPuDLpUyto/n9mkVhi93+NDIJAhi2ncqeQLZqqeYDxJUVLa/ZLy9WFx2YwZkc9GX67KF6iw/qWZTP86jveDdejACjoTwrlxr0TF48D8qbcjZVeEGswMPf1DVFDtUK0KZZXgsFWGQRrl1WM+wLXy0p5tUy3uqYJ99cW0/6DQDcX7XIIrF/37
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(396003)(376002)(346002)(136003)(39860400002)(6506007)(53546011)(186003)(6486002)(966005)(8936002)(26005)(6916009)(83380400001)(2616005)(5660300002)(41300700001)(54906003)(6512007)(71200400001)(91956017)(316002)(64756008)(76116006)(66476007)(66946007)(66556008)(2906002)(66446008)(8676002)(4326008)(38070700005)(38100700002)(86362001)(33656002)(36756003)(122000001)(478600001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mnf5ApbXkAJoUWbtlZWABlLMFZ5Yw4g+eXcMnvL17yS7Gs3V4V76Q95Pq+n7?=
 =?us-ascii?Q?jktpAji3xJhezXcSRqKMpmgAZy58AULohYU7qkgm3Ft23/q/N9VPnvzMFbZv?=
 =?us-ascii?Q?aW+NTHxOD87F72lEftiab/E6dTltSc4RLfY5CfJ7GUSLTyt+UdCMy0MvHIvP?=
 =?us-ascii?Q?PFc3F5cLGdFrSUBlqdH3lm09dpPVsmU+KAxT6kXPxYjQugwHIevXCEMF8gsK?=
 =?us-ascii?Q?8OFHgh2Jbl1c9gCQ7i5sew+Ux41FFCUfRMYkEBatTGE7gONh/uN481/ahQTP?=
 =?us-ascii?Q?XFQPGqMa/15GtASTU6t8vDVgIRp/HVaIZ2VrLJHxmDVWJDtKFOgzrqRpmxwh?=
 =?us-ascii?Q?Qe0qqCwwsh81uv1rnIZ3qkeTK2ETO1D4AsfjKeOPdnMJwqZvbbuX115B08vE?=
 =?us-ascii?Q?dXR8gQ8uROJQd6fE/Hclistrj1XUlmIdd7BEs9WX3+KWBtWnj5yv9inOBqnK?=
 =?us-ascii?Q?KZJceGCj3UoX+s05lprIRhpOdzg7XtafHCoD4j8EWln3KH9MLI33ms/+yBxw?=
 =?us-ascii?Q?UvfWqZKbZcTDx9D9vhpzzayK0X1HgWxkGwmf3VYVWlXSsbxnDy2ZV/yJ5st0?=
 =?us-ascii?Q?5UKezSsliqIoE/IcYK22FU5cgnMFvZusOEgfM3iTMn7QCuIkrGDh0VSwve8n?=
 =?us-ascii?Q?0J3XMTfRa9sgeqRasz+h7zvDKY5DQt0USY8aC/QP3PuOACIy2QK9etv36Bot?=
 =?us-ascii?Q?pJDawiXrpz+Tp535URkoYSFOO6HykncDN3wQ+Q6OU2E9RzZk6kUG9YSs3FAW?=
 =?us-ascii?Q?GK8e2L3ImACdeUXCjeUcVgjZWQH11FXcDPhyvCoR14nhHOqrSS8ymUo3qgSk?=
 =?us-ascii?Q?qr1x2RKt48aGypacBrCfWrW6tMsQUZyUUlKz7nfVbrzxC5QWT+aYAMwHDjTw?=
 =?us-ascii?Q?ab3Uy23h0YyhVPr5KHv1fwMCFAXuhh8pq77hTEly2zyZSvP1uoATlPVWGlXw?=
 =?us-ascii?Q?VgFOq/HrqroxRzGo/1RQPraKvQS8M+MwhX/U6kIalkG1Y/ge85furoAqAhDi?=
 =?us-ascii?Q?o8g7u683YyKppjVQWliZgOg7UmYTyCkS0C5uA2/tOYAwcnvOAqpOR14kZ0fe?=
 =?us-ascii?Q?mpF5LCf7hFWk/8uYBO1F7bkQ30eTtdYQruh5wWe3Aw2qJICxGFGBGfhj387Y?=
 =?us-ascii?Q?8YYEce0Yme/YzNoCx09aBMHZG/8hZSX81kCuTQQ99e7Hw0BF5cDyTeuo47ym?=
 =?us-ascii?Q?1OdSGPYOpLXiIKuVsTBjAG4eOFS9fOEk4pqKoXCw9bWzg9DLuV4OrmfjYXA2?=
 =?us-ascii?Q?6d+MTKJesbK+lILIY7Hou5Y8o3K8ZkHHLCoJgjHrsSS15/rV3LdOtY2xv6/f?=
 =?us-ascii?Q?TlhRKZaK22SUHsua7usqgM8+oIx8KizqQW4psp20pd1CCiV6X03UsOMaU3Iu?=
 =?us-ascii?Q?hnIUgUIi0CYvSV3eLQqShTy9uC/blsvcHCLcrG9c1wRIY+9WT4BM1g9TO2CU?=
 =?us-ascii?Q?WpNxyCV/qYKcyIsQGiszQ8ElJBazcGvXWxY9jsdJwdtKzFC7qBSVEKEirDFo?=
 =?us-ascii?Q?TuVgFxPMwKBgbP+KLJ5Od6oCmj40h7TsRL8X7HwmvUg93SFyF/dtHeoag2nj?=
 =?us-ascii?Q?LCRbKCN6jO8GKXAxhXTB/8wJ9RHUwCZadSHPwAlYDA2LD42fceryseX69K/V?=
 =?us-ascii?Q?rw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <AF180342595857469E0BD28B908BE491@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55a3dee6-e604-4003-d7a4-08da629335f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2022 16:42:43.1012
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IaQnTijElXMI6DmJqXQmyOIwNNw2VYOHsDSOptyWN1aQ6uupCRib+xR91glUQYMtKSi4x9+l/qrXbvBETKmxnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR10MB5416
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-10_16:2022-07-08,2022-07-10 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 phishscore=0 spamscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207100074
X-Proofpoint-GUID: tzDWZOIb6YzLJxklu8UnN9qCFN_d954_
X-Proofpoint-ORIG-GUID: tzDWZOIb6YzLJxklu8UnN9qCFN_d954_
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jul 10, 2022, at 6:43 AM, Igor Mammedov <imammedo@redhat.com> wrote:
>=20
> On Mon, 21 Mar 2022 14:12:31 +0000
> Chuck Lever III <chuck.lever@oracle.com> wrote:
>=20
> couldn't find offender patch on ML so replying here

Probably:

https://lore.kernel.org/linux-nfs/AEC24099-5BC9-49C8-B759-920824F23F3C@orac=
le.com/


>> Hi Linus-
>>=20
>> The following changes since commit 7e57714cd0ad2d5bb90e50b5096a0e671dec1=
ef3:
>>=20
>> Linux 5.17-rc6 (2022-02-27 14:36:33 -0800)
>>=20
>> are available in the Git repository at:
>>=20
>> git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-5.=
18
>>=20
>> for you to fetch changes up to 4fc5f5346592cdc91689455d83885b0af65d71b8:
>>=20
>> nfsd: fix using the correct variable for sizeof() (2022-03-20 12:49:38 -=
0400)
>>=20
>> ----------------------------------------------------------------
>> New features:
>> - NFSv3 support in NFSD is now always built
>> - Added NFSD support for the NFSv4 birth-time file attribute
> [...]
>=20
>> Ondrej Valousek (1):
>> nfsd: Add support for the birth time attribute

Thank you for the report, Igor.


> This patch regressed clients that support TIME_CREATE attribute.
> Starting with this patch client might think that server supports
> TIME_CREATE and start sending this attribute in its requests.

Indeed, e377a3e698fb ("nfsd: Add support for the birth time
attribute") does not include a change to nfsd4_decode_fattr4()
that decodes the birth time attribute.

I don't immediately see another storage protocol stack in our
kernel that supports a client setting the birth time, so NFSD
might have to ignore the client-provided value.


> However kernel on server side (since this patch and to
> current master) upon getting such request will return EINVAL.
> (my guess is that TIME_CREATE not being decoded properly and
> that messes up request parsing).

I'll send a quick-and-dirty fix your way as we explore the
question of whether NFSD needs to ignore the birth time value
in this case.


> End result is unusable mount (unless it's treated as readonly).

That seems odd, and not clear whether that's a client or server
problem. I hope that will clear up once the server deals with
the time_create attribute appropriately.


> Reproduces with current master (HEAD at e5524c2a1fc40) and MacOS
> client (Big Sur or newest Monterey).
>=20
> server is typical setup exporting files from XFS (Fedora36)
>=20
> #  rpcdebug -m nfsd -s all
>=20
> on client:
>=20
> % mount -t nfs -o vers=3D4,rw,nfc,sec=3Dsys testnas:/mnt  ~/test
> % touch ~/test/fff
>     touch: test/fff: Invalid argument
>=20
> server logs:
>=20
> nfsd: fh_compose(exp fd:00/128 fff, ino=3D0)
> NFSD: nfsd4_open filename  op_openowner 0000000000000000
>=20
> Here is a request the touch generates:
>        Network File System, Ops(6): PUTFH, SAVEFH, OPEN, GETATTR, RESTORE=
FH, GETATTR
>            [Program Version: 4]
>            [V4 Procedure: COMPOUND (1)]
>            Tag: create
>            minorversion: 0
>            Operations (count: 6): PUTFH, SAVEFH, OPEN, GETATTR, RESTOREFH=
, GETATTR
>                Opcode: PUTFH (22)
>                Opcode: SAVEFH (32)
>                Opcode: OPEN (18)
>                    seqid: 0x00000004
>                    share_access: OPEN4_SHARE_ACCESS_BOTH (3)
>                    share_deny: OPEN4_SHARE_DENY_NONE (0)
>                    clientid: 0xba93c9620aec46ea
>                    owner: <DATA>
>                    Open Type: OPEN4_CREATE (1)
>                        Create Mode: UNCHECKED4 (0)
>                        Attr mask: 0x00040002 (Mode, Time_Create)
>                            reco_attr: Mode (33)
>                            reco_attr: Time_Create (50)
>                    Claim Type: CLAIM_NULL (0)
>                        Name: fff
>=20
>        [...]
>=20
> when trying to copy file via GUI (Finder) it goes a different route
> but ends up with error anyway and with leftover 0-length file on server
> with messed up permissions, i.e.

The current NFSv4 OPEN(CREATE) code path is still not right. Fixing
the TIME_CREATE problem should make this symptom go away for now,
but eventually that path will need to be restructured so that it
cannot leave a turd if the whole create process was not able to
complete.


> open/create without Time_Create succeeds but followup
> setattr with Time_Create fails EINVAL.
>=20
>        Network File System, Ops(3): PUTFH, SETATTR, GETATTR
>            [Program Version: 4]
>            [V4 Procedure: COMPOUND (1)]
>            Tag: setattr
>            minorversion: 0
>            Operations (count: 3): PUTFH, SETATTR, GETATTR
>                Opcode: PUTFH (22)
>                Opcode: SETATTR (34)
>                    StateID
>                    Attr mask: 0x00450002 (Mode, Time_Access_Set, Time_Cre=
ate, Time_Modify_Set)
>                        reco_attr: Mode (33)
>                        reco_attr: Time_Access_Set (48)
>                        reco_attr: Time_Create (50)
>                        reco_attr: Time_Modify_Set (54)
>                Opcode: GETATTR (9)
>            [Main Opcode: SETATTR (34)]
>=20
> [...]
>> --
>> Chuck Lever

--
Chuck Lever




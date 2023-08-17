Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A350377F9C6
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Aug 2023 16:55:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347685AbjHQOzZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 17 Aug 2023 10:55:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352419AbjHQOzR (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 17 Aug 2023 10:55:17 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F43CE42;
        Thu, 17 Aug 2023 07:55:16 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37HCO3Up002808;
        Thu, 17 Aug 2023 14:55:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=NsuJ39wrOEyhJXP9kB1QdBuX6DFLkzX6/LwFbrE+V9A=;
 b=EoFKv0eqAUCat9SyFk23cz7Rb31rfwFBbPJJOdOvxXS3LiuNWYBobEfuGD5orMh4HT5X
 6mJ/ssxGgK4qstluKg2iZHsLkGcDrqv8pypfNHK+nvBqu62DWtRENIPuqIz6E9nbC+Hl
 0a2OtcipqjRUHRS703l7bGdGuImIdo7wyEcZ0lzfwHw8QC1XFnTtI1k3KEiCceF2yp0e
 6lj8GHmQMxsJjyliTLQM8lrDOTI6YEph7mP0uGazlo3/GPXRTBU64Abc0ogW5xDN6RFk
 nDYX3LTafBpV2AXHQIXUye77NyA7BrRSrMWZPrXNp4aJsQtw7KdzW6fjpFyBHMO0jYO7 9w== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3se2y31rjj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Aug 2023 14:55:12 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37HEGwgw039453;
        Thu, 17 Aug 2023 14:55:11 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3sey72x2fw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Aug 2023 14:55:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WLPQl9IOu/x9lX8VCg0Z9uwczRJtFvoG3EvtjcM7sIJ00yZSFegYPrddImV6Ve68iI5+oRQ8OfXAR2Nz3vbZVWesM4mMeAzr1hclQXyb5i3nlubHcWj0CkxDjlAMTGchJfWB/RMFW9DQcogqRk0NNjgb5E5B+9zBHaFPtM4Yo2yPLv+kChVBia0ek0538KP97y4SEWwJu0ADb/O2v7Elcia7TI/N21tbCYkDMIkOJCKalTs4XsITLsea9uMFtAHD4v3Xgvug7H+mXSCp4r1vQdEiwTDQiIv/FcRTMm9/WOrPkDEexjz3CObtb1IajITl1XKI9t77/rtg9kEYt4iSJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NsuJ39wrOEyhJXP9kB1QdBuX6DFLkzX6/LwFbrE+V9A=;
 b=HQmwDZGPvJGUGTl+2eWiFMGaDqRvr+/VD/GNDVTBDsTq0Hh6khEAvQOO5i9hGdPgmbbH3N39IjVx8FlwhYlDGTF1nkS28REc1LYSGhCjs3OdbuDJ1Wn1b3/ymanTVnO5F+4etvcLf4JfzYsrSy1omdtCtH7kiUdsDDbQoIGHZ+ahVKnEuilK1oiY6feqs/9gAy5hNEEOgF3x5Elbq2HmwTK9eYLX2/mQxyOjeJRwIKgdLgp0diPd2MGx7MfPdBnMCLBkJNWDZCZCKM8IzY32bnKeCxzhprUHRF4D2/SfK/SNAb1yguJ4l8pmGodAk2aqi76s66hZZVo22OTjHUabfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NsuJ39wrOEyhJXP9kB1QdBuX6DFLkzX6/LwFbrE+V9A=;
 b=HfuYTq0bnPmVh1xIOEBmf8ee/TujHYeAhTcG0oIeUIJPRDijjX9MJ+zn/9N/Hlw43zXfu96fWMMtPuyHJHtiohJ+R+5DQnLBOZSur42xJCcl+RlI7rxSX+puO/iRUF0IOjpSf1qIpiyEGLnPxSuEqB0jcdw7xiKb1SE990bJH3A=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH0PR10MB5819.namprd10.prod.outlook.com (2603:10b6:510:141::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.30; Thu, 17 Aug
 2023 14:55:08 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e%6]) with mapi id 15.20.6678.031; Thu, 17 Aug 2023
 14:55:08 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Jeff Layton <jlayton@kernel.org>
Subject: Re: [GIT PULL] one more nfsd fix for 6.5-rc
Thread-Topic: [GIT PULL] one more nfsd fix for 6.5-rc
Thread-Index: AQHZ0RSyOY8s+cfu7Eiqte+akPOXMa/ukeyAgAABfoA=
Date:   Thu, 17 Aug 2023 14:55:08 +0000
Message-ID: <27B358DC-D32E-46F5-B611-A179C6AB2B90@oracle.com>
References: <499058D2-E924-464F-BBFE-C15EE6028787@oracle.com>
 <CAHk-=whnm7RyZfy2s4BOdkMz=dMrPJRnH79KVH8rtC1vrV9G1w@mail.gmail.com>
In-Reply-To: <CAHk-=whnm7RyZfy2s4BOdkMz=dMrPJRnH79KVH8rtC1vrV9G1w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.700.6)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|PH0PR10MB5819:EE_
x-ms-office365-filtering-correlation-id: e47bda57-a188-48c1-4fcb-08db9f31f33d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EG4uD4orxMLHksNI2R/W83/x52D4gM8Iv7l9rgT+NiANBia6Vc6vslOpkXp/ebUSq8Fx+IxNUaoV564e/6HK60moowfvZVfHBHf3SGGAETlezImfyfgGHEVRSznXUoFyD71heWEOuM19WLOJChCejdtqAAr9KwE6I6C1AOMW3SL2ModXQ771rwcMUdk/wwyYbWbUPq39ws+byiJIH5Y37NTAxM/A5fAbomvkw9mNnqpvaaOwYuZSuCgE7JfRpJpfAa4m99cn/cZcGR5L0GfzGJ0noBtG3QP7LSc6zV4sL/iQO2BWRmlsV3/rJXROmGgSQgod3PE6jpviuBzpXzkfQKxggOcmGGGC0Z/XU9xUo6kOLufoDizV3TbsPOe36mP4fS4WuHVTgleVyeh6eVZCMhTn0lxW1z/arN4YSBVz/n5XgwXxPbzhPpyPiT52POHTX4H0GVrQoKCskcLerfQ9U9Namx2D/3fmnpANALKgElgze3KOIHgSG0Apa1/CyzDO7gBdEDC6OP2YXCYUXxv7K+WwPmDMrp7wkP3eMJKz2U3jvxQ+4tQ/gB1lOtvMGLtwL1pGZJNWaVTkoydUBC3HWWVbtjoqbtfAH5TPjSkR6PvVZuAjDqEDxp6IvbmD1WIcuZSq2OUl5aNxirc6hoG78I+QN2FEJGb7oBIvXVrVzoE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(136003)(366004)(396003)(346002)(186009)(451199024)(1800799009)(8936002)(66556008)(76116006)(64756008)(38070700005)(38100700002)(66446008)(6916009)(54906003)(66476007)(91956017)(966005)(316002)(478600001)(122000001)(66946007)(2906002)(41300700001)(4326008)(26005)(5660300002)(8676002)(6512007)(71200400001)(6506007)(53546011)(6486002)(2616005)(86362001)(33656002)(36756003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6Wp49hdNkuGMP8oSfGcKQx9zP9QVzaAck8CwmGTjW/Aa3GssnWMkX25D1fbi?=
 =?us-ascii?Q?+qRs0nZMUNXeTjzEjmYhklltwieVQZ2cbyiZieaCv1Dz6IqJQ7QQIjxNTfCE?=
 =?us-ascii?Q?NhzIELjQDPNmZhPw4nkFi27wEEzxv0YVL+ZQ8IupLmEczWKa6lfGW06PMGc/?=
 =?us-ascii?Q?ATkvS3IVVEwYZ6/yDIni0Fc0mtdluqLVcwfaULvt4hwoFqvhUmX367832FZh?=
 =?us-ascii?Q?l5plvulHvk3m4w3O2I066UTQpKdIyUghZj/RWnAxcT1fwh6RLYA6SiQhNvTj?=
 =?us-ascii?Q?lgKUiiIBw/wx12kwvZHCHek1wii71SJQrP0zbWxkMNO7qyEEEaUAeWUhXDlY?=
 =?us-ascii?Q?rS6CckKVNejmBWLb3omnjf0Ar2TpbU80dyM7d9JQpiqBDsYIGrouDq60AfQl?=
 =?us-ascii?Q?9J4fjsuhhIgPsPT9mTHwmqJa0PnX5r7Y6cUg7BzwwX+CN8QvFEueMBf3eRKl?=
 =?us-ascii?Q?iz0hD7DlSNauJElYTdmjFe4/FXLPwcJS+HIuYYesdPc4+73x2vnKwcrE7IGD?=
 =?us-ascii?Q?SrjxwhYCP8DCK/C91scCh1vrZNvbBmd7UMd9Ghmhpz/PZLKqC0DWHrHon6zU?=
 =?us-ascii?Q?DDz1xowZksrH9gJcVBc0GsOUreCeFvNR0l9gio0ycywuWLnS4d/fgFuQ5+4A?=
 =?us-ascii?Q?HeTEigwrq+bdxfN0jqfNgXQ9060p7wlnjjIkIqBeK5cYZwQdh0hS78OcgrTs?=
 =?us-ascii?Q?uh5/giSTU/cHwE3MD4EPcuKLyJDGDVdcgo65ne2hzidyR0GaqkDb+x/0EGUx?=
 =?us-ascii?Q?liLX5aq23S751nlUAkQfyoy5/6t5d8A7YQFBWsHH+dD84exNzZVixhcNVuuE?=
 =?us-ascii?Q?WwnUioKI2ko2+3eFSlb8Y2/xoEMssrdhVHCKlNIuRcOMYCjMQ46N969J16NL?=
 =?us-ascii?Q?k3EAGAX0fwUyRCJjHpJ8a8G4oOgfdtHzItowLR1wV6ijVgSQS9m+Ns/nxL1Z?=
 =?us-ascii?Q?YFl+tOlcLPGnadCY/jzUalGhnsYJbWdvLdWaQ/oaAm+hRFXXnWrrjpBiZJpQ?=
 =?us-ascii?Q?cvBPoXq3o/1OaIV/hI/8eNeShlVdAlMtLog6H0XUW7UdU8DC4cyS8kozheaJ?=
 =?us-ascii?Q?xG32MRSz1CxdopFzVDC0el+/u1kwwnbcw44E6TAkWgoxMZUYULBuymMwWs50?=
 =?us-ascii?Q?KxUv+/wZYw1+n2Xj7XrPUfaNafp8VUb0ZaRLFkjsF4Ashyt5NcN6cEyRn1ND?=
 =?us-ascii?Q?SRiTfQTaFePbrLHNRFZM8KQvTMXRbfC0tWm9hqxJ5FQKyYdbBevvH8NXgeOG?=
 =?us-ascii?Q?Ups2ETVduJWUnpXIuLRS3Ow/DF0eOxS5T1WN/Uk4o/OHmU5np89VfFVx7sT0?=
 =?us-ascii?Q?udaSsFl1HC8L6tAmyPbvRf2pzYxpCjfkYGShI6oKiuvxek7khxc1FlA80Q1l?=
 =?us-ascii?Q?LViDu1aFdpFPvBN6pdCglnofjKjYce8K7bYh4pXCQFvmqfFifktff7984MnQ?=
 =?us-ascii?Q?qKS7H4yERt56v6wibQ8IeDPGDae80s7t5jBih3daYm0yzan39jgVqhUt+cpt?=
 =?us-ascii?Q?Ekxb4my77oX4vCU2UYuNjk97PylSbOXOgpBU802X8jEm+rfpy0D/umNUJO4f?=
 =?us-ascii?Q?U9fQiWkdxgWh9jICfgq0mpUfdrcZ5x91bZO2LhBE9VPyjLDKP+9B3HfS9++s?=
 =?us-ascii?Q?zA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <02D72075BB302A419771E00165DCA0A3@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: efDwdW+AsFellmn75/wRDc/cYHGAXD1xg8LAIjZUKJbOxJilPjWAFz8gyQCtUBzKmL5Lm+M61CzbuTnzMtkdoUKxJ+Ysn/az0T/vInbBdJW/ji6AZDlB4W4Rigl7OEPnFhNV9eHFi0UEcSpFovqRzt6QrrbvQRSz8UswQB3NLsWk16utVIbXRPKKtrlzCtcdfgeegtO4k01M72vSCDBairEXKxVjTktEQXnu6A1v8yt8hVGhQy+GF2JEhBzk5BXg2QwGuaiupXPMfStlR6fJwuoV+XLBEZVXjWmPv9xX4CrLJqLkBHb84TIwtyUu18Id0YY4WijnCeLh0Ua3OxUMKkBim0pL4uwypPCE1GBuyq5659+Tt2ddlPaJrfoONDNOaK5AdQvk2xXnlEapDs/vur/Pn6K+X67KeZ6BSFhI9B+1oPwURm5rRYYEYmmnjporWZZVrbNo7Nbu2iIG3dpmFMLqnh3X08eDf93oIerv3vHqfEud3hG6xYGQeB7l90exrfA3a3Bc0X4L4nnolpE/2Xmg9EvYhB8EkoSkCMYqzxOkaJNh+4R/NO76UOPc6RzKEfTq4fBg1m7tzC3bHv0ZWrgRQxPJRSzgGVYFVka9oZQMqsTO8ltyqXSzveMRRaJxCahmb9p8vdxhLtt5V+/jbwA9t20EXCSghCgt5dJG9sxo9GVlBjdKL5yHkgYpxIhLojBISqk9BABLw/NHtathNa5tSl5RED9Hhh3jJvXwvMh/V3naimKmVULBwi97rMCYa5E3zthwPqoEha1LPcg/x8O+yzcTmtJlDkY2LBynaFyqMUwklu/W6LpmFNKgtVI+iEqOsNW0gUaymOW2UoOn4OO2th4H7i3ISxG0zSV7Gbc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e47bda57-a188-48c1-4fcb-08db9f31f33d
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2023 14:55:08.5971
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7IFJjdtYDxeu+6W0Lz2Jkh7DsVfUXWlsKzoVs6Qnp2bjxPxqGSXLfTT9YsFh0fOq4I6wi9R4ZMSCCxhvv1Kncg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5819
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-17_09,2023-08-17_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 bulkscore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308170132
X-Proofpoint-ORIG-GUID: kqZ8XGk346KSmr6T1ZsxzSF2h2G_-rYG
X-Proofpoint-GUID: kqZ8XGk346KSmr6T1ZsxzSF2h2G_-rYG
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Aug 17, 2023, at 10:49 AM, Linus Torvalds <torvalds@linux-foundation.o=
rg> wrote:
>=20
> On Thu, 17 Aug 2023 at 16:11, Chuck Lever III <chuck.lever@oracle.com> wr=
ote:
>>=20
>>  https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd=
-6.5-4
>=20
> I've pulled this, but...
>=20
>> Jeff Layton (1):
>>      sunrpc: set the bv_offset of first bvec in svc_tcp_sendmsg
>=20
> .. what an odd place to set bv_offset that is.
>=20
> I'm sure it's right, but it really smells odd to set that initial
> offset not when the bvec is created, but long afterwards, just before
> it is used.
>=20
> Is there some reason why 'bv_offset' isn't initialized when the bvec is c=
reated?

Yes:

https://lore.kernel.org/linux-nfs/7c9421cc4b92dee76cc7560c50a4a0ab3fb1ef0d.=
camel@kernel.org/T/#t

But also note that this fix will get replaced in v6.6:

https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git/commit/?h=3Dn=
fsd-next&id=3D383bc8bbc3e61d185ff8082cad2da831f158be4a

I just wanted to ensure that v6.5 wasn't broken. It's a little late in the
cycle to apply 383bc8bbc.

If you feel it's appropriate, perhaps you could add a link to the above
lore discussion to the fix... but as the fix is temporary, perhaps not
worth the bother.


--
Chuck Lever



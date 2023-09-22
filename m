Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23F547AB57F
	for <lists+linux-nfs@lfdr.de>; Fri, 22 Sep 2023 18:07:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230250AbjIVQHD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 22 Sep 2023 12:07:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjIVQHC (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 22 Sep 2023 12:07:02 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B753D100;
        Fri, 22 Sep 2023 09:06:56 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38MFuGKV016532;
        Fri, 22 Sep 2023 16:06:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=Vv2y1r84cGj+5b/NLq83L8hmvElcxfoiOdgRxkE6dz8=;
 b=dlm5Bd6k9Zh4hrBFpHQ19s0pjhUDIy1C/e85F7Vmri2FbDR2uXze9g9BB3gaWDt/t4J0
 L1wDsaJqircLSkcykEC4YZBbRUFf1J1iRALDvFN8ts6DoXZvz68ssPVdgu3NlTDfjYFS
 6qo5+qJG7zufIQaN4Fiw9WZWCW8+PqHLGHgFlP5kzSTxDwbNtKpSmZyyLGf48hKHFdLK
 oc2D3n1C2fozq+LZ0ts/MfPEXx7lOOfSEgL0VsHLy2fcptIeVL0EgIjJJRklH1RtHwhf
 AUMtkY2dh1d6QFPaEwXu+PN0Y7y0yykbPwwduV7MhOWIHDjzDTfmg6NChUDBHMQooXdp Jg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t8tsxt68y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Sep 2023 16:06:49 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38MFUSEG007584;
        Fri, 22 Sep 2023 16:06:47 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3t8uhcxyss-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Sep 2023 16:06:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BrZbfaj2C1L64UhrGICTVpiv280ju4sjdtgTcw0x2jvQjfTmGrpohOKKAr24rkXhkvKDIzGqV4nqKxmk4n+ligcTSw/I2QOPzR7ZPrg4lb1nD5NUHQ5LiYYgurFSrvVsqDjxiib/3fjXDS+ZvJLO7QgbAbU4Fr1z/oBiAJPvs1xsirwR2DryzvSFjfFC59ueTK7QoiG8wi3t/eEZ7bWpRlDXgaoP2rASYRZPisb08cTANw9uOPeajEou4cB4z98pJXB+It1XrSjFrcnx8jOaoitvo4nVmDjJ7XhL0kXwgfKbg7DRgwYhB6UyCO9W2Mmt5fA6WnXqHdLwNaolh01PkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vv2y1r84cGj+5b/NLq83L8hmvElcxfoiOdgRxkE6dz8=;
 b=Eko9Dtahr5aiVfuy/8lGQs9HeryOhGuxCyt+SFRtei9UV0LjH+DuXGZcy6/LJ+y1agKjXwHfliOjT4ZrxMPyqWPFPARdJ768h304me3QoE6CMNe4NKnjdyaDDJQr8WgoFqC3LeMe3aROGxEikz8Fdcxc8CodaPSXirEr2WcKjHAZrocEbgtCKpYDg5/YMutQDkO8Ih8x+wLwi8/AlGx5zP2xex9wktqUCdMLS1XN7d7S97qZz5+W6E1tH8CffcoLefxXGHEqXLqZ4F8Vc3OxhMtyMEruewVgKZtTCMmSAbHp+aTiivl0wXf7j0Q0iIt87DYVND1UsXlDQ7FcqjoYnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vv2y1r84cGj+5b/NLq83L8hmvElcxfoiOdgRxkE6dz8=;
 b=fBVLJgT8EDKR2QlI3bVgyb0nXQZv0e6JcAcTj3SJ47WA8cBxCKHKMuMwIUjJTi7j816dgMH902ZIZZhIMm23Va1zzFCEz1GwS6ZMHz8P65/g9nXYQqTkUk2JpuehC2v2cpfHJwVGYVAhUZaNzrQ6mxg3uo9XN0JiWzbnW7dwPRk=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS7PR10MB5376.namprd10.prod.outlook.com (2603:10b6:5:3a9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.24; Fri, 22 Sep
 2023 16:06:45 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::bffc:4f39:2aa8:6144]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::bffc:4f39:2aa8:6144%5]) with mapi id 15.20.6813.017; Fri, 22 Sep 2023
 16:06:44 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Lorenzo Bianconi <lorenzo@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Neil Brown <neilb@suse.de>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH] NFSD: convert write_threads and write_v4_end_grace to
 netlink commands
Thread-Topic: [PATCH] NFSD: convert write_threads and write_v4_end_grace to
 netlink commands
Thread-Index: AQHZ7VKfQ7YihRKqAEKLYXScgapUUbAnAk0AgAAAkQA=
Date:   Fri, 22 Sep 2023 16:06:44 +0000
Message-ID: <ADA8068B-B289-4210-9E28-E69F4EBB9355@oracle.com>
References: <b7985d6f0708d4a2836e1b488d641cdc11ace61b.1695386483.git.lorenzo@kernel.org>
 <cc6341a7c5f09b731298236b260c9dfd94a811d8.camel@kernel.org>
In-Reply-To: <cc6341a7c5f09b731298236b260c9dfd94a811d8.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.700.6)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|DS7PR10MB5376:EE_
x-ms-office365-filtering-correlation-id: 25f55fda-d66a-4b85-8356-08dbbb85eae9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eOwR8LqH+985rTCq8p+LggNVhKZbF5eCcgNkEggGGc5F479wmTbdN2tLvQ9BnITKhqLfqeP8kzTEqgSgfnUBRT9qx7Lf1dmX3Hn3yRg1B8Rf2iOdZ85uAsZm/ZL6Ai384YyZ4oGisBq9qZfj+KYs1vblozX4+EA17lbOkt2QF6YtH0/8+6fScp65co1ctXiMfAKRDSZLTkFGEzuhzBV6teFsyTul8bbz03N2T/tmMC7XvuzCXzF64A5nlnAh3RYI9K3nITk+EBMZzEfXIKRGeltyFOPG5Svtvp3RgymIG2J5ADNqkAVo9nFhGaM0/QZjSmAS5TQewwO8Ol/KPNSm90AzCwZa30x7QlrqizQE5238c5/8TLkyqYNxwnA8V+7/tSQfOGJYFcF8WGFwv+TtW2Nhff6PdinPnpX6hduRw4DDg7TiDHh8rHmtgzCI8cqfSpN9qy8ETFDU6me603HlHcV6/TsRALND2P29uK/MmshAVV8+ejGmVHrYrdcJr7rXmL8fJDWQ9HV/F4bXgGqPgqzJm5C0unAovxiggMEOY817ZTolw2Lpf0UXPutYfFqeC1o+vw3wCKDRK125sWSdjW3rKw54m05lxVMvvD2zt0uXovQjxLZUNg6h1QJzIVYsHqZ2FGhRfP8P+xax3utrgQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(396003)(376002)(346002)(39860400002)(186009)(1800799009)(451199024)(53546011)(6506007)(6486002)(966005)(71200400001)(478600001)(6512007)(2616005)(83380400001)(26005)(2906002)(66476007)(76116006)(6916009)(66556008)(316002)(66446008)(66946007)(64756008)(54906003)(91956017)(4326008)(8936002)(8676002)(41300700001)(5660300002)(38070700005)(36756003)(86362001)(33656002)(122000001)(38100700002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Y14OBaqdk0bWrNxDRoTqLKQssYmuc4VRPIIpbO9xscppAuoOusQ+z0OcvIdq?=
 =?us-ascii?Q?SKHlPF+RS3EuwedqLIH2aeNEbce4IwpfQWq0PAktnoUg4Ao/nxTVEbO4VVZp?=
 =?us-ascii?Q?t5sirOlWNj1DecNrbwIyWg8VTekM7jhYJEQnIj9sbjJlFFtkdXL9bcW2YAZR?=
 =?us-ascii?Q?LJBJMPdWVVXTkNeCPZrQyjMqnzhQsGd4InsUuUzJ99uIJQ3UO2RTYCKwl/zz?=
 =?us-ascii?Q?c9TFQ5toz+jcuOPunKjw9GeX+VDUQNKMvdo7n+O24x6bT8q8Gb4mSDQOkGfz?=
 =?us-ascii?Q?MV9jig4n3QLuH3BwjjIGfq+yh6DhKAGdXfJ2uE0RS4QWtkc8xuatVlGUJAvU?=
 =?us-ascii?Q?H59+7Pwr6R65bGQBBajlI3NA4Zt4XPSR5b0DxxRkfXpsLZclAtLoesrdm6D1?=
 =?us-ascii?Q?/NYjYWONk5sPMly5NahWtVPGSdcuVkRgqCjy0S7QMJ/NFirT6MG4ccykNuxt?=
 =?us-ascii?Q?QinYevs6BeXFfC9K8YTWvYR9YUwT+Mzj1QmMsJhhu2Gp9mlWz1pEUL8Bb+PH?=
 =?us-ascii?Q?XpVDfD2blv/pA4V+poNFhjc//0B18z3se5tK0HVdOA87hkRRCCC11JOktaCX?=
 =?us-ascii?Q?wnYtuCmCamQEL6UcDaVg08/4CdBFRGOU5SYVdpywg+I5HeFWXHe1fKA4hKqi?=
 =?us-ascii?Q?DcLWcCkFPitJqLlPsD1mEzAQSPjVgKgIZQNClAQCCuYXpPeAMIVb6hI1mUMN?=
 =?us-ascii?Q?mJuGnOnO+mOhTKKKKuSYV2GMHVydyUF3WEkfsBH9L843vdncTqNylwyPXK49?=
 =?us-ascii?Q?kp4C/wIg9p8RUlWINLuGP0CBoFOuE9tq7zE3oe5mng9s/XJD291IX6AbqB9Y?=
 =?us-ascii?Q?HTsZoAerYri9MXSjciWu4uAHdE8f2xrzMiRNcopWWuRqdm97oOB7x+heJMie?=
 =?us-ascii?Q?1wXV1lnu2HO1mheZUJtvxMx1krs2rCU1mUKMLS2WsZwWmy2K3CeWQpQQNjeN?=
 =?us-ascii?Q?Eq1pO94vGEeaBLTSrW34+nRTyxKxiwjLCfPOy5GadXFxQxK9wWb7DUsJgaZL?=
 =?us-ascii?Q?MNMD32gwkxvcxlp509ju/uyI6FhWOKEyrdmlJgKlIxbcGqNU0BRqbig6pzW4?=
 =?us-ascii?Q?JYpH3o7H7Vi3dCh+Tf2SaJ/X60BWXEPyavtfycSDUXuNfl8hjnfHH/1Lbd+V?=
 =?us-ascii?Q?JtLSOzOtDegHNqLe551iBWEUq5hvrQfLFUbmPSX5mlTNLGq9uxIENZDKc+BJ?=
 =?us-ascii?Q?xGKoXIfrmcNnB7F8d/WSnQJbPaBPhJVDznsEhhMt7YVIttvImeuLafhE6rCG?=
 =?us-ascii?Q?TH0uyvOO5VPw+CoS5W386yL5EhoG6oOmZoNaHSf+bGRr1PW24TzQkfTYZjPC?=
 =?us-ascii?Q?EbEH21ay6QtdwMYHAMxwXWeHHPx8U+mUe6zbNsSXqlynIMebbPYxo0AUmuro?=
 =?us-ascii?Q?RbCDSoCdZuIgGYaVVGMUhrOfpJ9UlxXzTClBeesDoXBpysDW+884MItxcGBP?=
 =?us-ascii?Q?r0sBgSgV1MwADW02hKC0EwtSn7s0ift5qe//a8+eE2AO6VjUVsk2K4P9fesH?=
 =?us-ascii?Q?VGJ7i5acvWwpRKa1cYh9lBj3x6OfwbYiapmby5xUR4I+mOALw8z6NbgQ8A+g?=
 =?us-ascii?Q?zd+yYnJNkseSqtA+o0zJ2TnzFUvR0bJ7P1XcvqmImTbGQEC8Siwj8Tq369HS?=
 =?us-ascii?Q?DA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <92FF45CC6D5E5341AF9C5FE24AB176F0@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: mDZ8ECoZMhD3WReCujB6Zs/HaMOmnhgV6qmuR4AQ0RLXVPFQG9n4wnr3FtwKHNKBWGm8AqDiK1MS/HSvjfeEk5z7GdRXu8CGVxTTxdtTYva28/Jm/Yy1nmzopfSnP+6DxWP2Df3YRUvgMAnlY36fcuVa6ag24xITRGLrIPRG/MCFc/xJFeb0/EoK4ACM5GR6Dp478RtvSXt+d6f457xm1+x7yQP0jDRAsTxJ76EkzXbsBwIOpgK+DQUKoRHuH7bgLJ1Ea7s6gV39ccxLtpTaIzg+OVthkUU1Gw+1uTPlP5h4dm8xoA9eg0Qii26IE3kfN2Q90fmZ4HxJ6dT8DGLfD2ExZ4Ump8eTT1QIvlgJKMlnvjLKeBoDwZpvCNslNb6DE7CCxxHSFOGyonZI3Adja/8Yt3+3fOFiz0k7RNCd6GFVBSS35y1t6ATgga4pBe1cq8ajUsiXL6iPzUm2KrbDVBReJfVqJLLtFZIjE8gcbGnGSa/tVxjWxMovqQlbU43B5ZCe+PZODNL+ildpm8Hgxo/LFwd4XHOE4VEH8il7Sz2XAwxftdRqZlzQyqATBDmz3DPDlAQDKCWAJMeMacVsBO1+BkfM2efx5VoFTHBA9PXFu+wLXebFoeb7Qn2OPCduBIyVtrpUvPzgaPCUCB9jyAArChTrB9EpWEaYQ8cCSJcuYpCBBOePH6Do7uoTzfReDrSYDMjaqX7RffDZI2hdJSgEEfeJmp9m7Hty3oqabHKBIBzl4Y5Kiy1ZOVEHtUewvsY9B5ck+Ut4fJHDVzSTbOzh1jclB9WvUD5U38mpiqs7jiZySM0k3YOyNq760rvhH3AiZEIUPdIT/UnHHpvAyw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25f55fda-d66a-4b85-8356-08dbbb85eae9
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2023 16:06:44.8954
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 03TeBVvGrLAkYm5OzrBGLGnZs/X3kFZCp/rghbWPUxp52FBxsMtYyD1ypfT6mNq4rdtDdYXSydyPny0FtcGUCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5376
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-22_14,2023-09-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 bulkscore=0 mlxlogscore=999 phishscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309220139
X-Proofpoint-ORIG-GUID: pdyr2rMlYD-wp8GUHKCg4B3q36E4mHjW
X-Proofpoint-GUID: pdyr2rMlYD-wp8GUHKCg4B3q36E4mHjW
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Sep 22, 2023, at 12:04 PM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> On Fri, 2023-09-22 at 14:44 +0200, Lorenzo Bianconi wrote:
>> Introduce write_threads and write_v4_end_grace netlink commands similar
>> to the ones available through the procfs.
>> Introduce nfsd_nl_server_status_get_dumpit netlink command in order to
>> report global server metadata.
>>=20
>> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
>> ---
>> This patch can be tested with user-space tool reported below:
>> https://github.com/LorenzoBianconi/nfsd-netlink.git
>> ---
>> Documentation/netlink/specs/nfsd.yaml | 33 +++++++++
>> fs/nfsd/netlink.c                     | 30 ++++++++
>> fs/nfsd/netlink.h                     |  5 ++
>> fs/nfsd/nfsctl.c                      | 98 +++++++++++++++++++++++++++
>> include/uapi/linux/nfsd_netlink.h     | 11 +++
>> 5 files changed, 177 insertions(+)
>>=20
>> diff --git a/Documentation/netlink/specs/nfsd.yaml b/Documentation/netli=
nk/specs/nfsd.yaml
>> index 403d3e3a04f3..fa1204892703 100644
>> --- a/Documentation/netlink/specs/nfsd.yaml
>> +++ b/Documentation/netlink/specs/nfsd.yaml
>> @@ -62,6 +62,15 @@ attribute-sets:
>>         name: compound-ops
>>         type: u32
>>         multi-attr: true
>> +  -
>> +    name: server-attr
>> +    attributes:
>> +      -
>> +        name: threads
>> +        type: u16
>=20
> 65k threads ought to be enough for anybody!

No argument.

But I thought you could echo a negative number of threads in /proc/fs/nfsd/=
threads
to reduce the thread count. Maybe this field should be an s32?


>> +      -
>> +        name: v4-grace
>> +        type: u8
>>=20
>> operations:
>>   list:
>> @@ -72,3 +81,27 @@ operations:
>>       dump:
>>         pre: nfsd-nl-rpc-status-get-start
>>         post: nfsd-nl-rpc-status-get-done
>> +    -
>> +      name: threads-set
>> +      doc: set the number of running threads
>> +      attribute-set: server-attr
>> +      flags: [ admin-perm ]
>> +      do:
>> +        request:
>> +          attributes:
>> +            - threads
>> +    -
>> +      name: v4-grace-release
>> +      doc: release the grace period for nfsd's v4 lock manager
>> +      attribute-set: server-attr
>> +      flags: [ admin-perm ]
>> +      do:
>> +        request:
>> +          attributes:
>> +            - v4-grace
>> +    -
>> +      name: server-status-get
>> +      doc: dump server status info
>> +      attribute-set: server-attr
>> +      dump:
>> +        pre: nfsd-nl-server-status-get-start
>> diff --git a/fs/nfsd/netlink.c b/fs/nfsd/netlink.c
>> index 0e1d635ec5f9..783a34e69354 100644
>> --- a/fs/nfsd/netlink.c
>> +++ b/fs/nfsd/netlink.c
>> @@ -10,6 +10,16 @@
>>=20
>> #include <uapi/linux/nfsd_netlink.h>
>>=20
>> +/* NFSD_CMD_THREADS_SET - do */
>> +static const struct nla_policy nfsd_threads_set_nl_policy[NFSD_A_SERVER=
_ATTR_THREADS + 1] =3D {
>> + [NFSD_A_SERVER_ATTR_THREADS] =3D { .type =3D NLA_U16, },
>> +};
>> +
>> +/* NFSD_CMD_V4_GRACE_RELEASE - do */
>> +static const struct nla_policy nfsd_v4_grace_release_nl_policy[NFSD_A_S=
ERVER_ATTR_V4_GRACE + 1] =3D {
>> + [NFSD_A_SERVER_ATTR_V4_GRACE] =3D { .type =3D NLA_U8, },
>> +};
>> +
>> /* Ops table for nfsd */
>> static const struct genl_split_ops nfsd_nl_ops[] =3D {
>> {
>> @@ -19,6 +29,26 @@ static const struct genl_split_ops nfsd_nl_ops[] =3D =
{
>> .done =3D nfsd_nl_rpc_status_get_done,
>> .flags =3D GENL_CMD_CAP_DUMP,
>> },
>> + {
>> + .cmd =3D NFSD_CMD_THREADS_SET,
>> + .doit =3D nfsd_nl_threads_set_doit,
>> + .policy =3D nfsd_threads_set_nl_policy,
>> + .maxattr =3D NFSD_A_SERVER_ATTR_THREADS,
>> + .flags =3D GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
>> + },
>> + {
>> + .cmd =3D NFSD_CMD_V4_GRACE_RELEASE,
>> + .doit =3D nfsd_nl_v4_grace_release_doit,
>> + .policy =3D nfsd_v4_grace_release_nl_policy,
>> + .maxattr =3D NFSD_A_SERVER_ATTR_V4_GRACE,
>> + .flags =3D GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
>> + },
>> + {
>> + .cmd =3D NFSD_CMD_SERVER_STATUS_GET,
>> + .start =3D nfsd_nl_server_status_get_start,
>> + .dumpit =3D nfsd_nl_server_status_get_dumpit,
>> + .flags =3D GENL_CMD_CAP_DUMP,
>> + },
>> };
>>=20
>> struct genl_family nfsd_nl_family __ro_after_init =3D {
>> diff --git a/fs/nfsd/netlink.h b/fs/nfsd/netlink.h
>> index d83dd6bdee92..2e98061fbb0a 100644
>> --- a/fs/nfsd/netlink.h
>> +++ b/fs/nfsd/netlink.h
>> @@ -12,10 +12,15 @@
>> #include <uapi/linux/nfsd_netlink.h>
>>=20
>> int nfsd_nl_rpc_status_get_start(struct netlink_callback *cb);
>> +int nfsd_nl_server_status_get_start(struct netlink_callback *cb);
>> int nfsd_nl_rpc_status_get_done(struct netlink_callback *cb);
>>=20
>> int nfsd_nl_rpc_status_get_dumpit(struct sk_buff *skb,
>>   struct netlink_callback *cb);
>> +int nfsd_nl_threads_set_doit(struct sk_buff *skb, struct genl_info *inf=
o);
>> +int nfsd_nl_v4_grace_release_doit(struct sk_buff *skb, struct genl_info=
 *info);
>> +int nfsd_nl_server_status_get_dumpit(struct sk_buff *skb,
>> +      struct netlink_callback *cb);
>>=20
>> extern struct genl_family nfsd_nl_family;
>>=20
>> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
>> index b71744e355a8..c631b59b7a4f 100644
>> --- a/fs/nfsd/nfsctl.c
>> +++ b/fs/nfsd/nfsctl.c
>> @@ -1694,6 +1694,104 @@ int nfsd_nl_rpc_status_get_done(struct netlink_c=
allback *cb)
>> return 0;
>> }
>>=20
>> +/**
>> + * nfsd_nl_threads_set_doit - set the number of running threads
>> + * @skb: reply buffer
>> + * @info: netlink metadata and command arguments
>> + *
>> + * Return 0 on success or a negative errno.
>> + */
>> +int nfsd_nl_threads_set_doit(struct sk_buff *skb, struct genl_info *inf=
o)
>> +{
>> + u16 nthreads;
>> + int ret;
>> +
>> + if (!info->attrs[NFSD_A_SERVER_ATTR_THREADS])
>> + return -EINVAL;
>> +
>> + nthreads =3D nla_get_u16(info->attrs[NFSD_A_SERVER_ATTR_THREADS]);
>> +
>> + ret =3D nfsd_svc(nthreads, genl_info_net(info), get_current_cred());
>> + return ret =3D=3D nthreads ? 0 : ret;
>> +}
>> +
>> +/**
>> + * nfsd_nl_v4_grace_release_doit - release the nfs4 grace period
>> + * @skb: reply buffer
>> + * @info: netlink metadata and command arguments
>> + *
>> + * Return 0 on success or a negative errno.
>> + */
>> +int nfsd_nl_v4_grace_release_doit(struct sk_buff *skb, struct genl_info=
 *info)
>> +{
>> +#ifdef CONFIG_NFSD_V4
>> + struct nfsd_net *nn =3D net_generic(genl_info_net(info), nfsd_net_id);
>> +
>> + if (!info->attrs[NFSD_A_SERVER_ATTR_V4_GRACE])
>> + return -EINVAL;
>> +
>> + if (nla_get_u8(info->attrs[NFSD_A_SERVER_ATTR_V4_GRACE]))
>> + nfsd4_end_grace(nn);
>> +
>=20
> To be clear here. Issuing this with anything but 0 will end the grace
> period. A value of 0 is ignored. It might be best to make the value not
> matter at all. Do we have to send down a value at all?
>=20
>> + return 0;
>> +#else
>> + return -EOPNOTSUPP;
>> +#endif /* CONFIG_NFSD_V4 */
>> +}
>> +
>> +/**
>> + * nfsd_nl_server_status_get_start - Prepare server_status_get dumpit
>> + * @cb: netlink metadata and command arguments
>> + *
>> + * Return values:
>> + *   %0: The server_status_get command may proceed
>> + *   %-ENODEV: There is no NFSD running in this namespace
>> + */
>> +int nfsd_nl_server_status_get_start(struct netlink_callback *cb)
>> +{
>> + struct nfsd_net *nn =3D net_generic(sock_net(cb->skb->sk), nfsd_net_id=
);
>> +
>> + return nn->nfsd_serv ? 0 : -ENODEV;
>> +}
>> +
>> +/**
>> + * nfsd_nl_server_status_get_dumpit - dump server status info
>> + * @skb: reply buffer
>> + * @cb: netlink metadata and command arguments
>> + *
>> + * Returns the size of the reply or a negative errno.
>> + */
>> +int nfsd_nl_server_status_get_dumpit(struct sk_buff *skb,
>> +      struct netlink_callback *cb)
>> +{
>> + struct net *net =3D sock_net(skb->sk);
>> +#ifdef CONFIG_NFSD_V4
>> + struct nfsd_net *nn =3D net_generic(net, nfsd_net_id);
>> +#endif /* CONFIG_NFSD_V4 */
>> + void *hdr;
>> +
>> + if (cb->args[0]) /* already consumed */
>> + return 0;
>> +
>> + hdr =3D genlmsg_put(skb, NETLINK_CB(cb->skb).portid, cb->nlh->nlmsg_se=
q,
>> +   &nfsd_nl_family, NLM_F_MULTI,
>> +   NFSD_CMD_SERVER_STATUS_GET);
>> + if (!hdr)
>> + return -ENOBUFS;
>> +
>> + if (nla_put_u16(skb, NFSD_A_SERVER_ATTR_THREADS, nfsd_nrthreads(net)))
>> + return -ENOBUFS;
>> +#ifdef CONFIG_NFSD_V4
>> + if (nla_put_u8(skb, NFSD_A_SERVER_ATTR_V4_GRACE, !nn->grace_ended))
>> + return -ENOBUFS;
>> +#endif /* CONFIG_NFSD_V4 */
>> +
>> + genlmsg_end(skb, hdr);
>> + cb->args[0] =3D 1;
>> +
>> + return skb->len;
>> +}
>> +
>> /**
>>  * nfsd_net_init - Prepare the nfsd_net portion of a new net namespace
>>  * @net: a freshly-created network namespace
>> diff --git a/include/uapi/linux/nfsd_netlink.h b/include/uapi/linux/nfsd=
_netlink.h
>> index c8ae72466ee6..b82fbc53d336 100644
>> --- a/include/uapi/linux/nfsd_netlink.h
>> +++ b/include/uapi/linux/nfsd_netlink.h
>> @@ -29,8 +29,19 @@ enum {
>> NFSD_A_RPC_STATUS_MAX =3D (__NFSD_A_RPC_STATUS_MAX - 1)
>> };
>>=20
>> +enum {
>> + NFSD_A_SERVER_ATTR_THREADS =3D 1,
>> + NFSD_A_SERVER_ATTR_V4_GRACE,
>> +
>> + __NFSD_A_SERVER_ATTR_MAX,
>> + NFSD_A_SERVER_ATTR_MAX =3D (__NFSD_A_SERVER_ATTR_MAX - 1)
>> +};
>> +
>> enum {
>> NFSD_CMD_RPC_STATUS_GET =3D 1,
>> + NFSD_CMD_THREADS_SET,
>> + NFSD_CMD_V4_GRACE_RELEASE,
>> + NFSD_CMD_SERVER_STATUS_GET,
>>=20
>> __NFSD_CMD_MAX,
>> NFSD_CMD_MAX =3D (__NFSD_CMD_MAX - 1)
>=20
> --=20
> Jeff Layton <jlayton@kernel.org>


--
Chuck Lever



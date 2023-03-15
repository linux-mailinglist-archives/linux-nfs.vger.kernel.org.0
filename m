Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C79A6BC1C1
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Mar 2023 00:51:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230333AbjCOXvc (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 15 Mar 2023 19:51:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232196AbjCOXvb (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 15 Mar 2023 19:51:31 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B5971CF62
        for <linux-nfs@vger.kernel.org>; Wed, 15 Mar 2023 16:51:27 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32FMnXhU001277;
        Wed, 15 Mar 2023 23:51:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=/t7RTmrFr7e3FZ+X2w4ar3yqDXhZO4rbH4k98GVcmgc=;
 b=gkStoRom6B/007wmBW4EqnF/1wVbfcXRhpRlVASI0z9ATdHkVx1O/FIQcL4rcUC7NfHy
 Gyzsd1D2mUV1uIf+M6bNQa+gZjEy/wX1VPiv9Ni1kSp81ybEoadTF5ua/ZmTZvDQ8Zfd
 8qlbpttnng/dcah8PQrQ8qHZyR0lCha2tRhI3tBw32SJIcA2DxduyuthEqKWzwujp8Io
 iNjTdyiolz3NgRH7EoxPbRgyDhhinxebIuZwrbkf7Cymb8j92mTQQt/VolM5YihcVa7Y
 niKRsYbMnusl7FFxmoq7nXfG+gv+pCUhSKzrT3g/fqow6kqIqXo4pnd5Y51lfpTElhv8 Vg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pbp4m85m9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Mar 2023 23:51:24 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32FMkxkI020511;
        Wed, 15 Mar 2023 23:51:23 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2044.outbound.protection.outlook.com [104.47.74.44])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3pbq45hkfr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Mar 2023 23:51:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HBExRHcop7QZLmd+pZG7dBEyKaG295J51rB937MDlop4hfJ2MdmFfrTGoC3qh1l3VdtCY8+7gsMOWhw1FFDY3ROMelaphNfVjWSOaFG41rm88XYIbNonH1mu095qwWm0DBkHC7Wc9m/rr9WR51Hk3af61GiznVRGpdu6hKLJiAcRJQRDeEbDzJqVmB0zbBISXArBqTjl5/AmyxsNVxCyqUawK9u0fXLSwMjlaQIrUeYVX0GMdsjv4v+NwuOTZjl5uU5/5idJbcFIW9qGO0P8XQe1Hu4wAlolprjA7TICoSXo6VPcHhi6Brv9I9eRWYBwfQuE2VcCGWu+e/KoW0Yggg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/t7RTmrFr7e3FZ+X2w4ar3yqDXhZO4rbH4k98GVcmgc=;
 b=TeqUq/t4jVYyf+yc4uhnDnsHPVyhu2n4oViljqMnDsA7naw5kmGtsdEUZtmdZiImgvrwsN6/y3SgcHAUX0FHBIisDYmleYWOggsxX990U4hYd0fjBlNGmB3wjyXbSXHLEI/XTUDnT3x7A1jARaZy9giwIYkth9qnWpQtrZ2Y9D3hoGmWlG470RyFc9cuic6UffbMfmCcjGJEXjnMs6DLPjPXYHkc/7ifVfjWJSzwWxkRIL8dOEbnBz7REp47btCknSipW6FY8rD1EQtBq8faug7DC/UFhTxP7AMGuR+oHHKHtUv9dF+5tg5Ax65KvYnaOx2KouFzfxYUNnx/LLQOGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/t7RTmrFr7e3FZ+X2w4ar3yqDXhZO4rbH4k98GVcmgc=;
 b=ziI/ObE49flWmJFhP+hkabEEAeUAnX/zVixV3GOM8AxJN5jhbo4OgXwsNb4R1sA2ynR1gTe3u6Q808DP96O0dNIwU1ipvpKTUybKzCEBHGPOgjxIVU44A61G3M8EkHAW9caAmSMzlbhrzIoGF9x+qkq9SBGXEHTKLa9UGO0F53Q=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA1PR10MB6148.namprd10.prod.outlook.com (2603:10b6:208:3a8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Wed, 15 Mar
 2023 23:51:13 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5c2f:5e81:b6c4:a127]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5c2f:5e81:b6c4:a127%6]) with mapi id 15.20.6178.030; Wed, 15 Mar 2023
 23:51:13 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Trevor Hemsley <trevor.hemsley@ntlworld.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: Crash in nfsd on kernel > 5.19
Thread-Topic: Crash in nfsd on kernel > 5.19
Thread-Index: AQHZV4sVEzmy0Wt5jECNGFBEfkrEpq78gvUA
Date:   Wed, 15 Mar 2023 23:51:13 +0000
Message-ID: <0498891A-C0EA-4007-A759-151CE93C59B5@oracle.com>
References: <6d3d381d-84b4-98c7-e6b2-a3b1ad25409b@ntlworld.com>
In-Reply-To: <6d3d381d-84b4-98c7-e6b2-a3b1ad25409b@ntlworld.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.2)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|IA1PR10MB6148:EE_
x-ms-office365-filtering-correlation-id: 7dcabbd6-08b5-48cf-4955-08db25b028de
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jGqHCJGxnWGxaJDkixRWrOKB2sWf8f5Au8suxgXG/drVRBX7HMQAoZ39bOJMjtqcS0eyFFBMV6iNDLNMNyypTy9AdxYyM1DDqd5XPvuCwD/0T0SfTqspma/Q5wSkHWzWDNvqqR53YwbE9QB9zd90QecNtaytju32uFEV5iU8aEp/aZTRYGOpV64KM3KpCN5iX8kDsN4aoEOU/DMn3Dcn0iynGWQIqU7Y8JtjMrYX/0bZe/Uj1hcpiUxxhNPsBTWzW12/xicCUKqqCRlN11UI4MhgbQ9rKCO4MVFFIfXz742v6HRePgsP8JaAcS2WiObyFGxgN3/T+1Fbn08p0B2Z1sow/K2aGnlijyv37jcXEHU0WDlLI3VhRKf1S8agyJ5aCg/Ov76LsOLSwGsyq5bqn4zzb6mZsNRTenJLHJGwlcgcbvLOudIDcSJU5ISQEIS8rBfII5G0FHFEfYpci8JC/y34SHl6o1ESqUFSxfUMlDvHc9wWsrlu7BEBfWIllUWJ7drkZhvn27st4rk2TveO2geSHTJPRTgnxb+A9IYVO5rCLbswNU+EeFpxr1rTkg4+gLzuAFO3LWddy8qH8kF1uVjCAub5OZS3MRtxVAAIk3LHPWUkx/Yf5cwCfJa20x2tF7ZG9jysqFoqh95jbSW+4JBXTAomM+We2otCURMGjvSoGV3/ZVpMSnNq/EwSG/cFtETy1Szk6e7jnTAvhHlaUqRvbALpAW+jknfok7v5ROcFjH8SpFy3s07OHAqylyUh
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(39860400002)(366004)(346002)(376002)(136003)(451199018)(83380400001)(33656002)(86362001)(36756003)(316002)(6506007)(966005)(64756008)(6486002)(186003)(8676002)(2906002)(66476007)(53546011)(71200400001)(66946007)(2616005)(26005)(66556008)(76116006)(41300700001)(6512007)(478600001)(66446008)(122000001)(38100700002)(5660300002)(4326008)(91956017)(6916009)(8936002)(38070700005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+IfIcGi3wQRfe2QH9R69uSsZ4ecmMLhpxK+LwbRnQPUS8CqavvvYO4w4+mIh?=
 =?us-ascii?Q?9jsFhr9CJOsvWwHuNtSFWIAaiCmBgYEMmoR5nYQBoJlpLTvxKpd6+PhXrIGW?=
 =?us-ascii?Q?HHPSqgw7xO3CQbqGWKpPBsmBwakzhix+0DLwkkwflmFiC0lj0g+jkoq9KKcz?=
 =?us-ascii?Q?p6EBJivuWPb2SFTyDmVOwnnRGW/6ZX7kIZWNIIkP35ve24TXqPO1MXpMIW88?=
 =?us-ascii?Q?CmXAJ0Ld6P9G3dIDVuRKyam0M+GVFQFK/1uQmERrd3bK5bAczr2SBpSfvVWo?=
 =?us-ascii?Q?sMy6WOzZRDCn4rV/hDlI1eeWbk7VqqP7R7Sg+9Wmq6Uhocu7M2UyYGtwSHXp?=
 =?us-ascii?Q?GukgNDc2QAdvbhMxZ8FEt4UdJCD3EcJYACWIV5BPSQa3+phJxlX9AOVHBQxW?=
 =?us-ascii?Q?Fl+irTrTEpBUxcNA43JZlXJ0j+30wCvb78aH0GVwTmdrzRqBmIcU7mU94O+O?=
 =?us-ascii?Q?6M/Lic5Qpkl27anwNgQ9KhZ0BkeRplo/DEcht2OTp7I9HSXK9cD+QqIlB//y?=
 =?us-ascii?Q?xrgk7jHMIfJzp0WUXrvCK2GtZCj2EMtnNe5tvGrYFc4c8hE1vlLp7HG7l1Ym?=
 =?us-ascii?Q?l3SCtQTDCRSo9vqRUnsawm9qBNnrvkTuXzhwbqHycdAGyOhtq3RM3lnH4yko?=
 =?us-ascii?Q?TvLH/wTqKKc23imMKRL1Q3R9+TZ6LdKNzzgzTa83vCrZaNY1LfVoe2tm0NXb?=
 =?us-ascii?Q?M4XTUXU70UQZOdP1momNq+RgA9WOSAmJqs04BerH81g/gV/YsPuakOBlzjVS?=
 =?us-ascii?Q?v/ISY03eSGqorp29vYw7hrM+P8s5Kf/STBcKZ7fDTNRO3ijL2MychJlZdG7h?=
 =?us-ascii?Q?lpMHocgcdyhjfXKxweRz2EKxF2IUZtUutXTeiTnYHtNH87JZ6YbXxlCegkny?=
 =?us-ascii?Q?g2tLog+ijtSPG3d23ruiTlOlF/qxbeKeN6Exj9Ll9ID26l0lPqO0nfV3sGZe?=
 =?us-ascii?Q?WiajQQIJRE1aQfk+Qh4kbjPPoaEe4LRHmXl80eG3njPWn0RzqVCKkJx+Xt+d?=
 =?us-ascii?Q?kXCGNjV7x0F3+fVfQVGQi3giFKJbVXB6d16rvbYvzHnwExkoxl+xgs69Q7rs?=
 =?us-ascii?Q?CP2HisGi7xz96/HCjLXPg5lrCA0/3G2Qt2121I4gtY/sHAlEF7K3zi2LK3Cj?=
 =?us-ascii?Q?wgUyjxPnfiXd6X/miryy1Jdk+tS3OBH54Vzcep12HynQLzdwrCYQZdwv+7Qq?=
 =?us-ascii?Q?e7DZIde82vLb5u7VNzarWtmO4adRZqwfPH8odlcDpI+eI9crPsyJ1dTOi9Wu?=
 =?us-ascii?Q?fRSh7373z7ka+JIk7w21P2DSrhAagi82jfTVEChC24/Qn2HL8fBgpzfnenmp?=
 =?us-ascii?Q?nrrOj/O+jDjy8b5K6noxVcpxatpOC4d/hyRL8hfY562TkNAYoS3I1uuFdfrX?=
 =?us-ascii?Q?QdMMekC1KDqsPRRspsNpp9J/AqiijWSzaJpetvfjW61Qo1Fb7+mEqmDIH5mb?=
 =?us-ascii?Q?h+2th6qhw9UNojtOSZp1s7B8dEAPRBA+T2EJmCuIdOxMUfpZba/JHQuYRq4M?=
 =?us-ascii?Q?9r5d/XTaLr16a3H6jPdXWSyGZqKfAIJ89wseUTc3tN2KmeoJkT8G3YBFcTtc?=
 =?us-ascii?Q?ugpno+Guc7DIP2WjCKvBy9sdrANxMUqmgTwhL84y5w08yN0WDRcyfLGHb5Xz?=
 =?us-ascii?Q?9w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <179166D68ADB8040BE4CC70DE1202DC8@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: XIb7WIrswERj+GsRVTe8hlz1FrvR2KNXU9zUkRtgqQQzocjuoPD5SuxhpmpA0S5/vq2hhO7gP6zdiV+n6LD6rU/rbtsJw8GpWqELSbFUq18O8lTZcLz8S2lamWoExT2FHFcEf1xIsOrITCFHB1IyOO8HxxKA/ZbArEnAF778jFu6hOwV/EJE++hxcSagxEAgVtwP7poM5CkZtEiW6W2B+feL0tg/yirtl5RAnfr57KjQNDFoETUbRbCu2qkYCbn7DR40OVYktALSGVKKdC1L56hWNF4wcyVPQvSWA8jOv5cJi8j3Ah1aNcaTA7QUFgJcp5VP9Fcm0pW4QugYe/EquHKqzPVqOET/dV9nXFwnMgsOq5VFXKda+RNdKjR6uE84dOxwb6WSHKWPkXZeoqosM3JXDS5yg3GBY2hDG5uWLfs4og0oWso0vXsRBrmEWKRTYCFxycfFhpZWF+R4uy8AcuLRe/hNitJiT8QE9jlSiA65jD8jAwGOikEMEq7irZLsKMl8j9HYpFzcilBMWUdT3Gqwz6pknKAsm+QVT17iTq3MLMNxZ2d+ir0feTZ2cliI5KQTm+eBpzqjoC5Zkn5iPH6foqwaDmfHwXRTrkHmaTUztkkz+HPQ8cjWbTcXfloXpBb6cyJ3sxSvURUtz0Kp5aJN7/hTI+jyrQpuRUJG+jt6DCOw0MA5aZFch4Qje5Z0rRUm0ZkhDpUQ3qtfyMXAs36yJPbrZdRCv4ZYDVjox2GJ7A6IyreGwwzbqM5TP6ZTEa0/WXGP5fQldmUn66+m1V0G/XGJFCDpBV64YmI40yc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dcabbd6-08b5-48cf-4955-08db25b028de
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2023 23:51:13.2716
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oJux9W7xAAo5hFHXH1xTRhBvf/RWTuhka2JxJKp5Hz/TiCBNRCE+ld750pFwy6Q2jvz4pThVgBuoyAb3r8LcjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6148
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-15_12,2023-03-15_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 phishscore=0
 suspectscore=0 spamscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303150002
 definitions=main-2303150194
X-Proofpoint-GUID: Vn-xjHCE_UdIIIb45d-6b3Lsr9-NoC4k
X-Proofpoint-ORIG-GUID: Vn-xjHCE_UdIIIb45d-6b3Lsr9-NoC4k
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Mar 15, 2023, at 6:01 PM, Trevor Hemsley <trevor.hemsley@ntlworld.com>=
 wrote:
>=20
> I have a problem using a media player called Kodi when it plays a media f=
ile that is hosted on an NFS share. Reverting to kernel-5.19.16-200.fc36.x8=
6_64 fixes the problem so I suspect this is a change made between 5.19 and =
6.0.
>=20
> I'm running libreelec 10.$latest as the client, which is distro specifica=
lly to allow kodi to run, and the problem is easily reproducible from there=
. All it takes is to play any movie/tv episode from an NFS share on a Fedor=
a 36 host and attempt to fast forward the motion. Within a second or two, i=
t crashes nfsd on the host. This started happening when Fedora updated from=
 kernel 5.19.x to 6.0.x. My first crash was on kernel 6.0.9 and it has happ=
ened with each 6.0.x minor update and with 6.1.x since.
>=20
> I raised a bugzilla entry https://bugzilla.redhat.com/show_bug.cgi?id=3D2=
148276 to report this and it has seen no traction. There are a few crashes =
detailed in the ticket. Several others have "me too'ed" that bugzilla and t=
he latest example is from an untainted kernel 6.1.15-200.fc37.x86_64. I fig=
ure it's time to try reporting it here instead.

This is probably a duplicate of https://bugzilla.redhat.com/show_bug.cgi?id=
=3D2150630
which is being actively worked right now.


> Am happy to test any patches if I can make them apply to the current Fedo=
ra 6.1.18 (latest) source

--
Chuck Lever



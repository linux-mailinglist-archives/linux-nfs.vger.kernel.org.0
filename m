Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A1A179B599
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Sep 2023 02:03:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbjIKXSK (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 11 Sep 2023 19:18:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352714AbjIKWZw (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 11 Sep 2023 18:25:52 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5366A4E211
        for <linux-nfs@vger.kernel.org>; Mon, 11 Sep 2023 15:12:39 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38BJcFpt030225;
        Mon, 11 Sep 2023 22:10:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=+H052bTeaUeaB3iQNtbPN0fFKO3QQatrkRPkoOLRKIg=;
 b=ko85xFHsDNBwxGID2n0XYKjSD9FIO/bKZbQL7aGEOdtheLgtBEN+zJG63kCon2z+JDuB
 uOSxMjoJWcqNmOfpYGzIDljQJVt0lTYXooJbzI1tUtW8R3sgbVIGlequNKqimE1DZcWi
 JzTId/vR7G3VIhcvz8DJlyAcJYVvhA/nGnJJ1O2/V+C7dCqO6KZob3/sjkypgcVvxnAF
 /d9zyKEOPOiXGbm/IebsjvwyqJ3OxJNpdwd59uU3I96aAwS+XkrVkekAIMNMXBUa9t6T
 ock7md9GkSHUylrSvjkJMPxMF4VHuOpM/3+QkFNyiZkseZSckNXPDel6yR5SP33ESnLo fg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t1jpatmb2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Sep 2023 22:10:52 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38BKJESa004468;
        Mon, 11 Sep 2023 22:10:51 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2107.outbound.protection.outlook.com [104.47.70.107])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3t0f55m0kd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Sep 2023 22:10:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jfWn1x42xvZSdmc0d//dnxr2kuazWsqp7ykTXglv0aKtkNOWvbWw5AA2+wQp90JAj2f2CYjxBnyF1d2ewpgmIvYAtIoWNSFOfpX+Bo/kfDTCkfUEwwg/kQ1/QEdaNL2Eo/cZMgdq7XUHTOAKG+9cq3LxCmfcpOxQZEjgmXSiSYl0oh6brCkx4V5LzMIwt2htTmDdjOHU6vPksWaGYz3eXrvjZQ1rihO2o/+w49YNtvlNRLpYehP8k8jnsNeoYwGvej8yCt7qr9JbBBb/jkMXZ5lIhZQuUvX96MDgMzt+JktXkoKs0QkO5kJNuCkdxpM9bzY6Nv0wNM41iyevV3fR2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+H052bTeaUeaB3iQNtbPN0fFKO3QQatrkRPkoOLRKIg=;
 b=IvTJ3W+8QDmoB3SeTPVfOxtNY36nf/hEDX8yJCOi4J1LwEjXyxa/3bwc3X4hUccL9BS+LJdYKeK9ZIR4CRp7gm4zErs49lEi3hVgSEfTb+eIdBb/d04BWIDwTlaSUQtgXuRRy9o+2nfurO3zVxyLPlkn+ZRniDrteftA/u6M+wWcWyrCZ4U3EvrHCqc08ZsUfa5139CFPZEx4+8gLwP9WY+SqmEacLNFYIkgxClYr+YY2TmrC3Mkopu41iOXYqHO2/tqRn0bSjT6tuMnNkdLO+zcnfArfGcFYvEi8v+R71/Y2Bi9NaLi8XKIfTM0bquw2YxOH/4Yt9baU+om0lxfvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+H052bTeaUeaB3iQNtbPN0fFKO3QQatrkRPkoOLRKIg=;
 b=MviVWYH7wei6IPrfWJxLyX8OO2irp0cyW+TIndwiVgXk2u9ogdOgMeuxfkXmnczxu0rh/lijKe+187mbf07c+EiXV+ZwanqihQhBZw92xtDsihGzjIrmcp3CD3ke88GoUjquURNnNAcvaJR6t1IaUE5CoFn/f1nmbWcZoMDXoek=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by LV8PR10MB7968.namprd10.prod.outlook.com (2603:10b6:408:200::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.35; Mon, 11 Sep
 2023 22:10:49 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e%6]) with mapi id 15.20.6768.029; Mon, 11 Sep 2023
 22:10:49 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] nfsd: Don't reset the write verifier on a commit EAGAIN
Thread-Topic: [PATCH] nfsd: Don't reset the write verifier on a commit EAGAIN
Thread-Index: AQHZ5ODKf/tGr/TkjUO+olrPJo1n67AWD0yAgAALTICAABU+gA==
Date:   Mon, 11 Sep 2023 22:10:49 +0000
Message-ID: <684AB86D-ADC7-44B0-BA54-FC23DB0B4670@oracle.com>
References: <20230911184357.11739-1-trond.myklebust@hammerspace.com>
 <ZP91EwHCt0/c0jvJ@tissot.1015granger.net>
 <f754d8a170b967d1523d103837eaeeb5e9a6c85b.camel@hammerspace.com>
In-Reply-To: <f754d8a170b967d1523d103837eaeeb5e9a6c85b.camel@hammerspace.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.700.6)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|LV8PR10MB7968:EE_
x-ms-office365-filtering-correlation-id: b7be1059-83cb-4dab-974a-08dbb313f4f6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: P9De0r/rtGtPvmrM2FOJBDVCiEFPQBhU5nVl5ZVKXZX00+MsTXvrkLu6EYEMpTRjLzYwiy8aMNFtU1e+ul8UlMfOwjnHfAnD9hxvqMpVH2+LcGO3ydne6zdQHJTp0eOxKOwvBCG3sKkUMzqjvCn+0I6kZVav75X/fx1DJOiMuu1XthNvXFH09F/RllnTF5B8Py4UGvONWCIWZQRlsX4Gr6iZsOm7OYV11G65Zfqs702aET4TvlwpWupvS2fQKzSg/L0SZ6/t4en+ZZ/tAjfaiDJDVkjSTSkO9PiGyJbR+94U9G2P6awzOxFJdyrrxvHSLpe5eLzZ3TROgZNn87sv3dQSA09eflGnsVAbOC5+aWA/sqefvfzv/0He9U51uP4QKeMNo16iECzUgl+sNipbzYG9ecG2e5m+ivFPj4uEfCpxll5vU5D/GyoAFMdHQSS6zo0ILfK9mD1K/0PXF+6EYW1GIGgEfNMSNi0R9K5NoYkZcZLflhXmMqOTBOWo1NbVtcVtXXugQlKT9Chy3SAT/hrZpIeIznTHrpHan0cwz5uGmVmh7a0uYQqyETf32mdsWYQ/qVFZ7xpqR/iU63Zl5K+3WKIEu0+AbT+IqngT0UT1/OCjCZuE0wOxK0LsyN6zbBwmmt55kYl8pryajH8fFQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(39860400002)(366004)(396003)(136003)(1800799009)(186009)(451199024)(83380400001)(478600001)(41300700001)(8676002)(5660300002)(4326008)(8936002)(6512007)(6486002)(6506007)(53546011)(71200400001)(316002)(6916009)(26005)(91956017)(66446008)(76116006)(66556008)(66476007)(64756008)(2616005)(66946007)(122000001)(2906002)(86362001)(38100700002)(38070700005)(33656002)(36756003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KR2RALqMyqCYIoRh7Te6eR8CwhGwapNrKQPrXRA/dueIiHxSb69dd2g53D6r?=
 =?us-ascii?Q?uDrnILCRH60eUmmV2vmbfCtFeo/IzN3LV2Da1DiB/I1+VlV+ItN0/qAgUFYR?=
 =?us-ascii?Q?FODeac9iNGvcsMQZ4lzgr8Y+lg3ULtUwmTSZiijjjDnaKPy/dVuqRiiCsbIs?=
 =?us-ascii?Q?BACE4p+vjJgJV5/iEnS9wXjaaffdPJ8vr92rOWFbtfHU2stqTVMrb3V3kRAh?=
 =?us-ascii?Q?KzWX4Ww0qaAyspvHPhZcr01f8+UhPX2cRpFD82D42epj4QTUwks3kvh/LreL?=
 =?us-ascii?Q?WB0sw8kVXZSXPju51Azo7P1aOJltboPh1CqC9V0oUsVh8KNAosiLYhEnWirO?=
 =?us-ascii?Q?jy9mgYWBMs0l7ed4zXbT7ooN14eJApTUAmT+CtbV1agiRo7/tFPhu1547zxv?=
 =?us-ascii?Q?Xrrv6g2DngGnyZayupCPO/fKJ3Kmsy56vY6WiRwGrthAGKyPBO06NBjKab+I?=
 =?us-ascii?Q?2ZCiHSoannuRjkTQNHBy4roKGWGGvqLvJD8TWkiZG5VhHjJYTWBJzgBusUjK?=
 =?us-ascii?Q?/cyJ4HaZ7MJ+lODOQM37kMOJuEBsbb4lmBJAQQ3u+Vng77sJqABZRmdHm0Hf?=
 =?us-ascii?Q?S2FOzpqTWvaraX5GIFuPWlxYk/WKsUUC/0urqPxeCtIFboCI1qp3SDkWr5IM?=
 =?us-ascii?Q?sJwfUa8b2vsIsdOTQClDzY5Rc/KQB/l+x7+oxVxaVmP6mXFBtarxEKGkEm50?=
 =?us-ascii?Q?V2+3urOOdRBGEMX+iAkUs8YFKQQNjAmEk/x9QPIzp0QclyyBvpCq5NyNkHla?=
 =?us-ascii?Q?t4KnvxxBwpi2kzh+Qofhs3t2hHqHh9Ygwgd6buiMDW1GZ6TJVqhPxNqIPCD0?=
 =?us-ascii?Q?Dhf6jSuBgNneKHrfyfoJ6BHKSXVO7oxtkkvGVyaScAG0fahkkHntUID1WmFr?=
 =?us-ascii?Q?GDlWuKsw+DG6nq7S/LHkn3N/VGON1wpoT9lSJdXmWyGRHKTeMO0tF/Cy2PUS?=
 =?us-ascii?Q?mK30u84xtukf16Zz/gkBpN9zdChPdn44D/58Pkx3Gptvl3SJnsN4CIRMaHH8?=
 =?us-ascii?Q?ACHdty34P6Q9TscibFStmr/dokOkK1bfCis27vsebCGoECU1GztCUnwzLeeR?=
 =?us-ascii?Q?8bwEsYVxeTck7ssOaAcQ8XQ84Zfjnv34c3t5w7xEbPKzVQ/r+7k4rYfX/Fed?=
 =?us-ascii?Q?J5CnNnNHzH3KKkdnFSIrprg3k86YkEUv5uJrOZps6vdZeqx0/0XgyB3vK53v?=
 =?us-ascii?Q?5Y936ZRRbTlLU2H3L90mvDiVulUZAw9GLJZVZZOJpxuge4nISFxxsXxeGDYB?=
 =?us-ascii?Q?JkH0UeIA2tKPNv+jpnG4K0CSmUTWSHHDr11BN5HTLp3fKuUdTz2KLe6TdNqf?=
 =?us-ascii?Q?+HR+k6RFfc99ThxnFwzTx3MGQ+roiIjihbZMzFgoGY16TWZllzE7IazEShpG?=
 =?us-ascii?Q?jHki2QkERHZolef2e8Z8x7kUomvMdlC896BZ241endCGpUhpmHcdH/zy+g+g?=
 =?us-ascii?Q?ud1LJ1FYifyFZrhPVdaMCZvrrXsj35XX0UBcL2/dwwQxIwTwp7XgCKTKAsPW?=
 =?us-ascii?Q?Tt1tUObicKk7Lb+amc1tIUYOE4JAQoes7oZV9TNqAGWXDGB/AocR1wNq/4i8?=
 =?us-ascii?Q?V1BTqETXHvCntJx/cNGnZlqnn6Fs+ZzZYN/2mY/WM2q3ABA68/r0W26AqFJ0?=
 =?us-ascii?Q?/Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <EE6A8C45387A2F43AB157AFA928AD1E8@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 4vBhDDpihF0UjfQI+4fS7fUtEQOpGopvynxR5VJgFX7eTFJSHGtP3GLuz/x9k4CRtlQkGc8I5D7FWYPlm2aV6xjWZKipSGLgMKqNKKZCx3nkU39+Tv8IP5mlQ4an+57p1k4GPqZ0EVkk/W4PRsgeuaEEDzg6r501JUpZrNCFdVbi0Wi9ibUSAeWFeS/+0nGiekjnyo2qKHrXVicmw9H+B6H/sRzUNBE097x18mfW+2v/rzEDUqZNo8U3cz2Tqj7LNLCxHPzNMt9SbEbcxlV/jE/jnhGnWB47DHpnpW1eP2V3KEyqzpXuJgfyqJloAuECSrA4XfXNJLu8iOeTd6O5vM4vrR+8cCjjZVpA0zrcq+H5TlvvLmHuVERrkb0s60aJV5djfujWofiz3xapUDLilg2Hc6NHStBT0Ncr+ni1q7q7g3N+Vxz4CphKkeN4SV1v23NlqEwbm6+f6HsoRj7oDWhcOxJMFTqVnL2vrfStWfkc5BEKnPSHcZCSjcmdhKZPzTzSAZtAmhIfyDoHU2aV+/dgRMyvqb0LjRgtHrfmqGyd008dGeyqr8JFmCFGpxC6Q/SZYEcCDdfq1sU0wCMD5HLe5xJ137dS82ZzUz3L4pOCS0rPyVlgKADXbS5Q1HJvPdOaTjgQOpxA2xeP6Q37tTwkl4Ffxad6b9RRtaB15xmntL86ICWhsHpLnStznTP6SOMWBaAmvjSBajEBXUY7Zk8cARWvH/3HgmHib5PPMnBwQK5v2etGlkyEcWyTgZ9T8o8N1mH68L1IjWaFTfWD3MIT5Wlb49xPiUmdCD2NxTl6int+Xe27/kWBXbUGJ9NR
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7be1059-83cb-4dab-974a-08dbb313f4f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2023 22:10:49.8306
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0gIXQ2/c3p2bVrYDUHyLkQ2lTzmqcNZi/bpEnMevjWkfp+9LB+zzRqwtxq4MTHgE0s3fI1ARqIYumzLY4SvFDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7968
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-11_18,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 adultscore=0
 phishscore=0 spamscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309110204
X-Proofpoint-GUID: kV23dEeqofJIlNX66AR-jPIa5_QCXUxy
X-Proofpoint-ORIG-GUID: kV23dEeqofJIlNX66AR-jPIa5_QCXUxy
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


> On Sep 11, 2023, at 4:54 PM, Trond Myklebust <trondmy@hammerspace.com> wr=
ote:
>=20
> On Mon, 2023-09-11 at 16:14 -0400, Chuck Lever wrote:
>> On Mon, Sep 11, 2023 at 02:43:57PM -0400, trondmy@gmail.com wrote:
>>> From: Trond Myklebust <trond.myklebust@hammerspace.com>
>>>=20
>>> If fsync() is returning EAGAIN, then we can assume that the
>>> filesystem
>>> being exported is something like NFS with the 'softerr' mount
>>> option
>>> enabled, and that it is just asking us to replay the fsync()
>>> operation
>>> at a later date.
>>> If we see an ESTALE, then ditto: the file is gone, so there is no
>>> danger
>>> of losing the error.
>>> For those cases, do not reset the write verifier.
>>=20
>> Out of interest, what's the hazard in a write verifier change in
>> these cases? There could be a slight performance penalty, I imagine,
>> but how frequently does this happen?
>=20
> When re-exporting to NFSv4 clients, it should be less of a problem,
> since any REMOVE will result in a sillyrenamed file that only
> disappears once the file is closed. However with NFSv3 clients, that is
> circumvented by the fact that the filecache closes the files when they
> are inactive. We've seen this occur frequently with VMware vmdks: their
> lock files appear to generate a lot of these phantom ESTALE writes.
>=20
> As for EAGAIN, I just pushed out a 2 patch client series that makes it
> a lot more frequent when re-exporting NFSv4 with 'softerr'.
>=20
> Finally, it is worth noting that a write verifier change has a global
> effect, causing retransmission by all clients of all uncommitted
> unstable writes for all files, so is worth mitigating where possible.

Good info. I've added some of this to the patch description.


>> One more below.
>>=20
>>=20
>>> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
>>> ---
>>>  fs/nfsd/vfs.c | 29 +++++++++++++++++++----------
>>>  1 file changed, 19 insertions(+), 10 deletions(-)
>>>=20
>>> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
>>> index 98fa4fd0556d..31daf9f63572 100644
>>> --- a/fs/nfsd/vfs.c
>>> +++ b/fs/nfsd/vfs.c
>>> @@ -337,6 +337,20 @@ nfsd_lookup(struct svc_rqst *rqstp, struct
>>> svc_fh *fhp, const char *name,
>>>         return err;
>>>  }
>>> =20
>>> +static void
>>> +commit_reset_write_verifier(struct nfsd_net *nn, struct svc_rqst
>>> *rqstp,
>>> +                           int err)
>>> +{
>>> +       switch (err) {
>>> +       case -EAGAIN:
>>> +       case -ESTALE:
>>> +               break;
>>> +       default:
>>> +               nfsd_reset_write_verifier(nn);
>>> +               trace_nfsd_writeverf_reset(nn, rqstp, err);
>>> +       }
>>> +}
>>> +
>>>  /*
>>>   * Commit metadata changes to stable storage.
>>>   */
>>> @@ -647,8 +661,7 @@ __be32 nfsd4_clone_file_range(struct svc_rqst
>>> *rqstp,
>>>                                         &nfsd4_get_cstate(rqstp)-
>>>> current_fh,
>>>                                         dst_pos,
>>>                                         count, status);
>>> -                       nfsd_reset_write_verifier(nn);
>>> -                       trace_nfsd_writeverf_reset(nn, rqstp,
>>> status);
>>> +                       commit_reset_write_verifier(nn, rqstp,
>>> status);
>>>                         ret =3D nfserrno(status);
>>>                 }
>>>         }
>>> @@ -1170,8 +1183,7 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct
>>> svc_fh *fhp, struct nfsd_file *nf,
>>>         host_err =3D vfs_iter_write(file, &iter, &pos, flags);
>>>         file_end_write(file);
>>>         if (host_err < 0) {
>>> -               nfsd_reset_write_verifier(nn);
>>> -               trace_nfsd_writeverf_reset(nn, rqstp, host_err);
>>> +               commit_reset_write_verifier(nn, rqstp, host_err);
>>=20
>> Can generic_file_write_iter() or its brethren return STALE or AGAIN
>> before they get to the generic_write_sync() call ?
>=20
> The call to nfs_revalidate_file_size(), which can occur when you are
> appending to the file (whether or not O_APPEND is set) could indeed
> return ESTALE.
> With the new patchset mentioned above, it could also return EAGAIN.

Sounds like I should drop this hunk when applying this fix.


>>>                 goto out_nfserr;
>>>         }
>>>         *cnt =3D host_err;
>>> @@ -1183,10 +1195,8 @@ nfsd_vfs_write(struct svc_rqst *rqstp,
>>> struct svc_fh *fhp, struct nfsd_file *nf,
>>> =20
>>>         if (stable && use_wgather) {
>>>                 host_err =3D wait_for_concurrent_writes(file);
>>> -               if (host_err < 0) {
>>> -                       nfsd_reset_write_verifier(nn);
>>> -                       trace_nfsd_writeverf_reset(nn, rqstp,
>>> host_err);
>>> -               }
>>> +               if (host_err < 0)
>>> +                       commit_reset_write_verifier(nn, rqstp,
>>> host_err);
>>>         }
>>> =20
>>>  out_nfserr:
>>> @@ -1329,8 +1339,7 @@ nfsd_commit(struct svc_rqst *rqstp, struct
>>> svc_fh *fhp, struct nfsd_file *nf,
>>>                         err =3D nfserr_notsupp;
>>>                         break;
>>>                 default:
>>> -                       nfsd_reset_write_verifier(nn);
>>> -                       trace_nfsd_writeverf_reset(nn, rqstp,
>>> err2);
>>> +                       commit_reset_write_verifier(nn, rqstp,
>>> err2);
>>>                         err =3D nfserrno(err2);
>>>                 }
>>>         } else
>>> --=20
>>> 2.41.0
>>>=20
>>=20
>=20
> --=20
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com


--
Chuck Lever



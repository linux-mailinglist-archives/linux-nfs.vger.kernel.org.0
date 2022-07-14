Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95F9F575374
	for <lists+linux-nfs@lfdr.de>; Thu, 14 Jul 2022 18:53:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbiGNQxp (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 14 Jul 2022 12:53:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbiGNQxo (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 14 Jul 2022 12:53:44 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1A5B6581
        for <linux-nfs@vger.kernel.org>; Thu, 14 Jul 2022 09:53:41 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26EFtwq5008483;
        Thu, 14 Jul 2022 16:53:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=2gzbi9fJG91G8sEAMjXmBLkadml6wX16idsbO8EJS5k=;
 b=lfFOFtcYSYB8y53PMypr2sZoqskvfduBoCp5q4MKsmw/nq0Pk+ekXWpwZZGgCZSFr191
 rQQEMTOvE7lRwC6zx2EaRE3vMA4+dfmigGWBI8kql+c/XgwWF6IefUJfPZAUYt0PJljM
 2k/yf7Uu5LJ6q7V0m8i8sCw7oPitTWizuz3J+McZ//amSK/C/DZUDqygikkCDK2Y0oZp
 iP+ZKjkzwD2AbtaRO9dDbWTU6FiG898xuaH25KhgBNMmS+M43jVvy4s4Emsi14cclX2i
 APakM8/jtMxp6y2Mi2V1Wd5sxw5l+rPHCzeJOLfQIO0GCAOIvxWi/Qq6dmpkfp0ciZQU Og== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h71scdvtv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Jul 2022 16:53:32 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 26EGorJK003985;
        Thu, 14 Jul 2022 16:53:32 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2106.outbound.protection.outlook.com [104.47.55.106])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3h70461nbb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Jul 2022 16:53:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fc0xGwzCjClVckx+8qblKCnp3P1ypuRn1Ggxz3gw1zP/JPkWINxpMljDbBjzH86FYOBn6Kfi17vx6NtIPBaKP6/6DCIVNFjCcEZMqUdeDGDaINxZN24nFaHH3YSmWDKEXAUhsjNWvxnAGltyNu9AnJSzdMIn+P+K6Sdz7wAPJQTivtVYNaZnZB50QcJghUhH++KfgwetZ6M4HUZOYoIAh67ZZxZ0DqQ/BtFhHT/jdu1f2M2a+k4GhP2Gk2IHE7rCyItFOEB8iNvYodA9Sl6t8GyviAuLeW77C/Ziu/EK27I8H2/43q2edwakJrzMIsxyQb9F51LRbvmBMkO6kZ1RYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2gzbi9fJG91G8sEAMjXmBLkadml6wX16idsbO8EJS5k=;
 b=HIemHaZ3R3iaAQdVw3QLxAhd4GkU8ziq3bVQKMImSE79L9/iBlEmlaWVshhFgB0ZONz048OGCzEz/xlTYExxMG9QQfTd/hiGyTzgOqkcWiscsmNxuafId662+OEjuKannRKZ/LEdkUK57q/YdS0a9qSfuo1AdeerqKVWnxXawRa1xrxtJunmlSxd1FpJIUL0+pKCngdrQNjzWAGsUiGmFPssGK3Q5eVRa2Q4OlDkw9Y0ZYHMnw8QqvR7ij35GzcAyqL9/pUY37woKR/FIK4mZN/yo23UOriRfTF4CqIkI/xTZ35H4KHNcyuyEF/F04BYK8mjXQmBZgPrg0Cup/dwtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2gzbi9fJG91G8sEAMjXmBLkadml6wX16idsbO8EJS5k=;
 b=AeY7TOHBBMlyFa5nRjoO3Vrw0kVpo00KTb2rFGBAqQjxm0BoUiN3+SgehSQfT4rGTSYtJrATAKGbwbH99A0540F/A9l1R3rC83lDDJ/X4684LnaSINsn7xehxPkdE6lH1BqNXQMTD0MX/MeGwwAaNGaKM5ygzw0ERORmVZ3Wj5c=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BN0PR10MB4824.namprd10.prod.outlook.com (2603:10b6:408:12f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.14; Thu, 14 Jul
 2022 16:53:29 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::8cc6:21c7:b3e7:5da6]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::8cc6:21c7:b3e7:5da6%7]) with mapi id 15.20.5438.015; Thu, 14 Jul 2022
 16:53:29 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Neil Brown <neilb@suse.de>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [RFC PATCH 3/3] nfsd: vet the opened dentry after setting a
 delegation
Thread-Topic: [RFC PATCH 3/3] nfsd: vet the opened dentry after setting a
 delegation
Thread-Index: AQHYl5Zd8iYZiuQn7Uu02hG/3WLfuK1+FU4A
Date:   Thu, 14 Jul 2022 16:53:28 +0000
Message-ID: <F7B94422-F889-49DA-AA38-0D8AA1F9B682@oracle.com>
References: <20220714152819.128276-1-jlayton@kernel.org>
 <20220714152819.128276-4-jlayton@kernel.org>
In-Reply-To: <20220714152819.128276-4-jlayton@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.100.31)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1ef2cb34-89c1-4e51-ece7-08da65b96092
x-ms-traffictypediagnostic: BN0PR10MB4824:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TPj8ryIxdwYpAWgUpAXkf7ZXu+d7pnFr+142THHzZbrwF1sThWPiBhsIVgFD9PVQHdxLINqXu7pIxVEpsw4Vq+OsNQdvTgbt3nR/n8zZnOprb7BZ/btmFm+CGmjL5auzjoL3C8Tr+Q6WVAj6Wet/uZoXnbgAjyskku6U7kv6nWC0CuHyU2nnANbd1OtKsziI3jQCwzmbH+oO8SR1QmnYuPTn7CWOxNoLChEemJ6EcbT85FQPTB7B0c56qoEQQ0s4+iNmgRK96J6qJ6dINXKUgYhMRJZXKM3gzDsV1WC+IR1z5RFmpMhOxEP5EeCu3idFutra0MoLZ+bot16AaqLcBofFZBmF99VOQawr+UvMsCYDuAmt+nrTT8iWV/zBJt6poYes54r0eEot9JCHlIuCzdL1OEBvupUcnwgoAh/Fz3TcHCE4Sf9kE8OliAUmjj7Mzw1wxH+VLyuUfnpQpJaRTLGVKRo+UNVHPgpddNvVRwncmbNxEHfYH9zti/b9YxHcBq/fROw2HGXpJoPQxyucmMjBBdZzS8KtGnHdaaAxAMy7VLc5Yq7PSp8zn/ntApn4W1511aWlrKd3S5XBqBabX9FOicdxNoBZi9lS9S2m1doxC+wtByUARcssHXehZOK4BMetaqEyAp8L01trmxgMtRtsfktj0Mk34F74IjkaNv2I8QUO9ZhPXTLei14ESmvYoVuX1LcJ5VQKMePFXiMNimLKoPDeoxSTa1q2fNRCMbM6r7QUpEv/9txovCEsd2l65hiqln8U6B6Zq1zqRr3z0W4hUtBy2v7ZspDmIJFSvYF9qvb5Gu83lK2aq3bQ3P3o3eZY64+m14dCcFFYVz1QB1hwv4hL3N+W19+0R3VBlbs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(396003)(366004)(39860400002)(136003)(376002)(36756003)(8936002)(66556008)(4326008)(5660300002)(2906002)(33656002)(316002)(6916009)(54906003)(71200400001)(64756008)(76116006)(66446008)(66476007)(66946007)(91956017)(86362001)(8676002)(26005)(6512007)(186003)(53546011)(478600001)(41300700001)(6506007)(6486002)(2616005)(38070700005)(83380400001)(122000001)(38100700002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?C4D/CiQ176d3pByPUxhuMgqY5WxOYc/BF6D4fV3rx863+B0SfUzF8Rpskbys?=
 =?us-ascii?Q?eeNl+v1AZw5857BIOu5ngUYLBRPwu113sBC+inK4mmJN+ubbcRJ19fJyMG3P?=
 =?us-ascii?Q?2j/vLpXZJuWkpZB5apuA9rAripi7l9V80L96eIYJjgnjw9neL7c5NqibKzNj?=
 =?us-ascii?Q?6THSBqPQ/DPTJ2R7+tbtpfaeFWxcPFsH48sIjCXIqrQoDOPmPMy20ty1v477?=
 =?us-ascii?Q?/yp20FFQU+FFJ+cn/R+nGoi3apVVnZKLXNsZ1CNkMU9kfK8DFE780AI5+LIf?=
 =?us-ascii?Q?31/pgsi/bQuncVG6R/6h42f5dZduVhEaWcYG/qnEpzeTsRm8L5Q0Zr03XpVz?=
 =?us-ascii?Q?WntC/fOU6EsfAs1PuEFV+U2UJ7Kn83QeHzkiYsWfX6W0XcehKRAWry6ReXwj?=
 =?us-ascii?Q?K9lYQ2TasJzRDmDPIuU00UBxRruRlSuxC9uombhGDI6rIll+ZIJNCN2GCao0?=
 =?us-ascii?Q?AOtrpJkqzjR/JMJJNZr/wGSMoOlScm4mdg0CtHmph1umjQ81N1kBJ4Z/kamL?=
 =?us-ascii?Q?ggkIwfaZxUk+RRYxM6849ETYrQBruRgwDwA84c9sn8DoC8mv4oAdHDk20Ru8?=
 =?us-ascii?Q?KbugmQZV0rqBj9vlZpX2HMpz8O7MUIX0U+CF03WTBPycETX5NacYhqHvLlot?=
 =?us-ascii?Q?AHWWBGisLwK73he059zsAdh9/a+8HUnbbDLNq7+rA44QUZpgZ21InerBBm3z?=
 =?us-ascii?Q?cbK+Agb0a2A7Hst6ZBQcHilgywOo8zkIlNN8uAp40leN6EBGUhfItzwJWlWF?=
 =?us-ascii?Q?FJRZ0G0swnEitP4a9vtPj7kGSp5ttpxYtbwPxCWsfhL08K3DYHCrajZxzwmt?=
 =?us-ascii?Q?odoSISxz8bNbtb0MnlT/zjmWG0aTB4rrXHgOMk4nKFyjt1PVsK1NPPPgSXA4?=
 =?us-ascii?Q?xTPpy7Rqs0ePGF774VB2+X/BcM98CBClxZOrMtpzE4JeZGA8ITpaGpf0hITB?=
 =?us-ascii?Q?6Q+gd/Jg8e+lvJ3RfJe1GsLA3zbzjDrjAZ7dj9soh0ZD8edzJMozPbHxFFd2?=
 =?us-ascii?Q?gwBCOqJWYdgacl2NDMlUAK+LKZyga6P7TpF6Ju07ACA1q2i6dUv1alYwfNlY?=
 =?us-ascii?Q?RJJKnGbA/a6BBrHxxEungL/SchgGrhHY5GNn2c/LDWtJu0ydA8fyaldqIN87?=
 =?us-ascii?Q?AsivU9rzlwBBTtLN4j52/8qcJeWsss8Vml1kUfhR4bCc2ZRkTsH1j6s6yBNu?=
 =?us-ascii?Q?5r6GIJHjZePZXEbu4v/bDWAehq6ivUpT/YoLsqWjcPpKN6HhAe/AMEW4lQxJ?=
 =?us-ascii?Q?BDebOcI2PW+WqRje6fEbI21Yw6byc5lftqVmzWVBGlt38nEVTjU65jZr8EEk?=
 =?us-ascii?Q?CrJDuEBfxN9TSYWf9ZmwHHxz7ztncZEgaxjBiXNy/c/Vq2NWcSE+n7HYjbz3?=
 =?us-ascii?Q?MDfGn4J3T+0feesq+Sj6M9/ePL2jCdilHbnPNAMrfWg5S6QonEecY98oTdqN?=
 =?us-ascii?Q?GzgWy5xwjmrSOD7atjeMVFngJVvLDXeRiwnmT4Ee87SGePvum9B0oHVOHZai?=
 =?us-ascii?Q?q7cLTiW706J2/QYvFB86ohG2WbspciIz6Tsk5thhhAir1Bw1F5JfNGkKSlRK?=
 =?us-ascii?Q?JJPb6Xl01JKDdERhsf5DTNtjX3GAgnVFpq6OSPoefF6n2X0HQQzwlAENJEae?=
 =?us-ascii?Q?9Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <61E9A520C1B09742A3635458F373DAF4@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ef2cb34-89c1-4e51-ece7-08da65b96092
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2022 16:53:28.9630
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MZsBWYOfYyn0GxsPdJjt4KCPqbGD1allZsMAOyGGaez+F5Oboy12kcK6KUCs9xBkUVkhsok31H0Fpr6dJ4UuNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4824
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-14_14:2022-07-14,2022-07-14 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 phishscore=0 spamscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207140073
X-Proofpoint-GUID: xbj3yFvJTFvxM0XKlkhxY4vjGEIC6Lr7
X-Proofpoint-ORIG-GUID: xbj3yFvJTFvxM0XKlkhxY4vjGEIC6Lr7
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jul 14, 2022, at 11:28 AM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> Between opening a file and setting a delegation on it, someone could
> rename or unlink the dentry. If this happens, we do not want to grant a
> delegation on the open.
>=20
> Take the i_rwsem before setting the delegation. If we're granted a
> lease, redo the lookup of the file being opened and validate that the
> resulting dentry matches the one in the open file description. We only
> need to do this for the CLAIM_NULL open case however.
>=20
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
> fs/nfsd/nfs4state.c | 55 ++++++++++++++++++++++++++++++++++++++++-----
> 1 file changed, 50 insertions(+), 5 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 347794028c98..e5c7f6690d2d 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -1172,6 +1172,7 @@ alloc_init_deleg(struct nfs4_client *clp, struct nf=
s4_file *fp,
>=20
> void
> nfs4_put_stid(struct nfs4_stid *s)
> +	__releases(&clp->cl_lock)
> {
> 	struct nfs4_file *fp =3D s->sc_file;
> 	struct nfs4_client *clp =3D s->sc_client;

This hunk causes a bunch of new sparse warnings:

/home/cel/src/linux/klimt/include/linux/list.h:137:19: warning: context imb=
alance in 'put_clnt_odstate' - unexpected unlock
/home/cel/src/linux/klimt/fs/nfsd/nfs4state.c:1174:1: warning: context imba=
lance in 'nfs4_put_stid' - different lock contexts for basic block
/home/cel/src/linux/klimt/fs/nfsd/nfs4state.c:1230:13: warning: context imb=
alance in 'destroy_unhashed_deleg' - unexpected unlock
/home/cel/src/linux/klimt/fs/nfsd/nfs4state.c:1528:17: warning: context imb=
alance in 'release_lock_stateid' - unexpected unlock
/home/cel/src/linux/klimt/fs/nfsd/nfs4state.c:1624:17: warning: context imb=
alance in 'release_last_closed_stateid' - unexpected unlock
/home/cel/src/linux/klimt/fs/nfsd/nfs4state.c:2212:22: warning: context imb=
alance in '__destroy_client' - unexpected unlock
/home/cel/src/linux/klimt/fs/nfsd/nfs4state.c:4481:17: warning: context imb=
alance in 'nfsd4_find_and_lock_existing_open' - unexpected unlock
/home/cel/src/linux/klimt/fs/nfsd/nfs4state.c:4557:25: warning: context imb=
alance in 'init_open_stateid' - unexpected unlock
/home/cel/src/linux/klimt/fs/nfsd/nfs4state.c:4606:17: warning: context imb=
alance in 'move_to_close_lru' - unexpected unlock
/home/cel/src/linux/klimt/fs/nfsd/nfs4state.c:4752:13: warning: context imb=
alance in 'nfsd4_cb_recall_release' - unexpected unlock
/home/cel/src/linux/klimt/fs/nfsd/nfs4state.c:5003:17: warning: context imb=
alance in 'nfs4_check_deleg' - unexpected unlock
/home/cel/src/linux/klimt/fs/nfsd/nfs4state.c:5392:9: warning: context imba=
lance in 'nfs4_set_delegation' - unexpected unlock
/home/cel/src/linux/klimt/fs/nfsd/nfs4state.c:5467:9: warning: context imba=
lance in 'nfs4_open_delegation' - unexpected unlock
/home/cel/src/linux/klimt/fs/nfsd/nfs4state.c:5619:17: warning: context imb=
alance in 'nfsd4_process_open2' - unexpected unlock
/home/cel/src/linux/klimt/fs/nfsd/nfs4state.c:5638:17: warning: context imb=
alance in 'nfsd4_cleanup_open_state' - unexpected unlock
/home/cel/src/linux/klimt/fs/nfsd/nfs4state.c:5934:27: warning: context imb=
alance in 'nfs4_laundromat' - different lock contexts for basic block
/home/cel/src/linux/klimt/fs/nfsd/nfs4state.c:6160:17: warning: context imb=
alance in 'nfsd4_lookup_stateid' - unexpected unlock
/home/cel/src/linux/klimt/fs/nfsd/nfs4state.c:6374:25: warning: context imb=
alance in 'nfs4_preprocess_stateid_op' - unexpected unlock
/home/cel/src/linux/klimt/fs/nfsd/nfs4state.c:6422:9: warning: context imba=
lance in 'nfsd4_free_lock_stateid' - unexpected unlock
/home/cel/src/linux/klimt/fs/nfsd/nfs4state.c:6459:28: warning: context imb=
alance in 'nfsd4_free_stateid' - unexpected unlock
/home/cel/src/linux/klimt/fs/nfsd/nfs4state.c:6528:17: warning: context imb=
alance in 'nfs4_preprocess_seqid_op' - unexpected unlock
/home/cel/src/linux/klimt/fs/nfsd/nfs4state.c:6545:17: warning: context imb=
alance in 'nfs4_preprocess_confirmed_seqid_op' - unexpected unlock
/home/cel/src/linux/klimt/fs/nfsd/nfs4state.c:6588:9: warning: context imba=
lance in 'nfsd4_open_confirm' - unexpected unlock
/home/cel/src/linux/klimt/fs/nfsd/nfs4state.c:6657:9: warning: context imba=
lance in 'nfsd4_open_downgrade' - unexpected unlock
/home/cel/src/linux/klimt/fs/nfsd/nfs4state.c:6730:9: warning: context imba=
lance in 'nfsd4_close' - unexpected unlock
/home/cel/src/linux/klimt/fs/nfsd/nfs4state.c:6762:9: warning: context imba=
lance in 'nfsd4_delegreturn' - unexpected unlock
/home/cel/src/linux/klimt/fs/nfsd/nfs4state.c:7034:17: warning: context imb=
alance in 'init_lock_stateid' - unexpected unlock
/home/cel/src/linux/klimt/fs/nfsd/nfs4state.c:7063:17: warning: context imb=
alance in 'find_or_create_lock_stateid' - unexpected unlock
/home/cel/src/linux/klimt/fs/nfsd/nfs4state.c:7362:17: warning: context imb=
alance in 'nfsd4_lock' - unexpected unlock
/home/cel/src/linux/klimt/fs/nfsd/nfs4state.c:7535:9: warning: context imba=
lance in 'nfsd4_locku' - unexpected unlock

Let's repair the "/home/cel/src/linux/klimt/fs/nfsd/nfs4state.c:1185:9:
warning: context imbalance in 'nfs4_put_stid' - unexpected unlock" message
in a separate patch.

Otherwise, this seems reasonable and the surgery is not invasive.
Do you have a sense of the overhead of this new check?


> @@ -5259,13 +5260,41 @@ static int nfsd4_check_conflicting_opens(struct n=
fs4_client *clp,
> 	return 0;
> }
>=20
> +/*
> + * It's possible that between opening the dentry and setting the delegat=
ion,
> + * that it has been renamed or unlinked. Redo the lookup to validate tha=
t this
> + * hasn't happened.
> + */
> +static int
> +nfsd4_vet_deleg_parent(struct nfsd4_open *open, struct nfs4_file *fp, st=
ruct dentry *parent)
> +{
> +	struct dentry *child;
> +
> +	/* Only need to do this if this is an open-by-name */
> +	if (!parent)
> +		return 0;
> +
> +	child =3D lookup_one_len(open->op_fname, parent, open->op_fnamelen);
> +	if (IS_ERR(child))
> +		return PTR_ERR(child);
> +	dput(child);
> +
> +	/* Uh-oh, there has been a rename or unlink of the file. No deleg! */
> +	if (child !=3D file_dentry(fp->fi_deleg_file->nf_file))
> +		return -EAGAIN;
> +
> +	return 0;
> +}
> +
> static struct nfs4_delegation *
> -nfs4_set_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp=
)
> +nfs4_set_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp=
,
> +		    struct svc_fh *parent_fh)
> {
> 	int status =3D 0;
> 	struct nfs4_client *clp =3D stp->st_stid.sc_client;
> 	struct nfs4_file *fp =3D stp->st_stid.sc_file;
> 	struct nfs4_clnt_odstate *odstate =3D stp->st_clnt_odstate;
> +	struct dentry *parent =3D parent_fh ? parent_fh->fh_dentry : NULL;
> 	struct nfs4_delegation *dp;
> 	struct nfsd_file *nf;
> 	struct file_lock *fl;
> @@ -5315,11 +5344,23 @@ nfs4_set_delegation(struct nfsd4_open *open, stru=
ct nfs4_ol_stateid *stp)
> 	if (!fl)
> 		goto out_clnt_odstate;
>=20
> +	if (parent)
> +		inode_lock_shared_nested(d_inode(parent), I_MUTEX_PARENT);
> 	status =3D vfs_setlease(fp->fi_deleg_file->nf_file, fl->fl_type, &fl, NU=
LL);
> 	if (fl)
> 		locks_free_lock(fl);
> -	if (status)
> +	if (status) {
> +		if (parent)
> +			inode_unlock_shared(d_inode(parent));
> 		goto out_clnt_odstate;
> +	}
> +
> +	status =3D nfsd4_vet_deleg_parent(open, fp, parent);
> +	if (parent)
> +		inode_unlock_shared(d_inode(parent));
> +	if (status)
> +		goto out_unlock;
> +
> 	status =3D nfsd4_check_conflicting_opens(clp, fp);
> 	if (status)
> 		goto out_unlock;
> @@ -5375,11 +5416,13 @@ static void nfsd4_open_deleg_none_ext(struct nfsd=
4_open *open, int status)
>  * proper support for them.
>  */
> static void
> -nfs4_open_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *st=
p)
> +nfs4_open_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *st=
p,
> +		     struct svc_fh *current_fh)
> {
> 	struct nfs4_delegation *dp;
> 	struct nfs4_openowner *oo =3D openowner(stp->st_stateowner);
> 	struct nfs4_client *clp =3D stp->st_stid.sc_client;
> +	struct svc_fh *parent_fh =3D NULL;
> 	int cb_up;
> 	int status =3D 0;
>=20
> @@ -5393,6 +5436,8 @@ nfs4_open_delegation(struct nfsd4_open *open, struc=
t nfs4_ol_stateid *stp)
> 				goto out_no_deleg;
> 			break;
> 		case NFS4_OPEN_CLAIM_NULL:
> +			parent_fh =3D current_fh;
> +			fallthrough;
> 		case NFS4_OPEN_CLAIM_FH:
> 			/*
> 			 * Let's not give out any delegations till everyone's
> @@ -5407,7 +5452,7 @@ nfs4_open_delegation(struct nfsd4_open *open, struc=
t nfs4_ol_stateid *stp)
> 		default:
> 			goto out_no_deleg;
> 	}
> -	dp =3D nfs4_set_delegation(open, stp);
> +	dp =3D nfs4_set_delegation(open, stp, parent_fh);
> 	if (IS_ERR(dp))
> 		goto out_no_deleg;
>=20
> @@ -5539,7 +5584,7 @@ nfsd4_process_open2(struct svc_rqst *rqstp, struct =
svc_fh *current_fh, struct nf
> 	* Attempt to hand out a delegation. No error return, because the
> 	* OPEN succeeds even if we fail.
> 	*/
> -	nfs4_open_delegation(open, stp);
> +	nfs4_open_delegation(open, stp, &resp->cstate.current_fh);
> nodeleg:
> 	status =3D nfs_ok;
> 	trace_nfsd_open(&stp->st_stid.sc_stateid);
> --=20
> 2.36.1
>=20

--
Chuck Lever




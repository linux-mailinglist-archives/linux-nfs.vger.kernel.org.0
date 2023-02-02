Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA2726887A6
	for <lists+linux-nfs@lfdr.de>; Thu,  2 Feb 2023 20:41:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232619AbjBBTlp (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 2 Feb 2023 14:41:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232795AbjBBTlm (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 2 Feb 2023 14:41:42 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFEF180000;
        Thu,  2 Feb 2023 11:41:39 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 312IDq5v001798;
        Thu, 2 Feb 2023 19:41:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=2KMPmDt2RiS1/bpC7qO/yix+BsiPrLqnHZO7+gB/j3c=;
 b=awI4GvKQGJ2jax8H2EoZ+y7VNUZXvEidK0erjehQZWa8ykrfcldWoEnmzqKHMYHDan+P
 KCpKa5fH0bYqXduReBPVQTUH2YpcAJYxyS3gTx6VhQZaANQzxccsanleAZfXATfU9PBn
 SS5tgFKYNhAAjMK/YOHZxplANuGq8iu8imJRMS4t+vNDUBnRpn0FtBGmVKyPTTomH/gS
 QawFXnX4RA1lytGg6bvZFVqygahgC9t5kn7hV4X2nIfj4FWYpC+oLKvTrQ9oh0CErzC2
 j/vEoc1iD1jj9d8QoDFSF+frYZPaqZH+rxNU6GufHHNrOodcuJrLhXOB2vzapV2mS3aT ug== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nfk64c90n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Feb 2023 19:41:29 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 312Jd1Tf040656;
        Thu, 2 Feb 2023 19:41:29 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2047.outbound.protection.outlook.com [104.47.74.47])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3nct59ggm2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Feb 2023 19:41:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aY3UD43+GGsgonMaGcIi99/0EGr16N5UfVDCtHq7E615RLd/u7C17o6VsusoIJqK7QNDFeHPnZgzBOwgKH3be/qyQU8GGG51s7I3XNrC912acr4rrxRZiUWU0oOPZoKmTT+7/dL9nNPM+wfhpZ4ZiLnzT+d4NHV1S9UwxkTcE0YocHHhf25qT7fRwq+ICZ9M450B4b5mDxKkrqeMpGbygTV3sMzBb+hfEp9T7O4QTJXbjZB5AYcAHQqGzyhnULPdwFkVKkgUlntOUUzp9Fy8LhIItXQbh6I6AdwGWAvk2MyvuJvUYru1Evj2aW+7stpSFG1A8Nq3q0U8qJnxMLxG3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2KMPmDt2RiS1/bpC7qO/yix+BsiPrLqnHZO7+gB/j3c=;
 b=ZkPAqBQ0EtScsKpX5TBQjD6apD3ZFGG+gVjaLNho1OlltalG3/AuLjxNeA+fXuE3XiHzej8Acwh8AtYsZ6Mof4+i7N4JNWeiMXmAbFVDajm1viOf0l+CC46dsGSfvr6fSk0hWdp1Zp7exIhbV4zM+PgNKtbXXZ5McX1aojcsBquwsI1Qze86HTfzyZMEHRotke+tqdzgxZwQ4oPq2KNWUPG3Upnhz0wh0GnOidNRtLuindzG8YCZPFhYg4aNthnKR7Lonq2SavLUTIFlt87psCn3E4whRPpGE7mqx95mq0/yeXTAtWAJ09rbtJoqMcodCaorkgvIw1CBzMEaogoylg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2KMPmDt2RiS1/bpC7qO/yix+BsiPrLqnHZO7+gB/j3c=;
 b=d7H1QIAVgNGkNPvQ4eZ/1nI83CEWrqUFwA+inLDT8GqRsNnlENu9PzQvg5NjzG5OkjKRiSiz7TrOV0bGzEQgVxIU/CE6FOR+A4z1c3SLMTQzXrXmppOnCKR4FWDa8/fJJU3aG0K7Su5v5wr+q7mu5oRwYOru0LG7tqj4OISzr98=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA1PR10MB7513.namprd10.prod.outlook.com (2603:10b6:208:451::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.7; Thu, 2 Feb
 2023 19:41:26 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::96a2:2d53:eb8c:b5ed]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::96a2:2d53:eb8c:b5ed%4]) with mapi id 15.20.6086.007; Thu, 2 Feb 2023
 19:41:26 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>, Dai Ngo <dai.ngo@oracle.com>
CC:     Pumpkin <cc85nod@gmail.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] NFSD: fix deny mode logic in nfs4_upgrade_open
Thread-Topic: [PATCH] NFSD: fix deny mode logic in nfs4_upgrade_open
Thread-Index: AQHZNtkQTUc54cGJ8kWHJe+mTHkMtq68DvmA
Date:   Thu, 2 Feb 2023 19:41:26 +0000
Message-ID: <CBAFB3E5-5737-47A7-8234-3A771E908C4F@oracle.com>
References: <20230202073611.13106-1-cc85nod@gmail.com>
In-Reply-To: <20230202073611.13106-1-cc85nod@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.2)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|IA1PR10MB7513:EE_
x-ms-office365-filtering-correlation-id: 7e055a97-909e-40da-b13c-08db0555794e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: o9SUUfBRdenwfIC2Qp+FXCbDKnu+SMurSG5RZ3/MGmrMApqqvQt0Cyxr3fPVqkyd7wq0iR99XsKvSuwD+71t/toiGVVV/h4zV2JJomOEqKy+hfCKsQj26AdcfibluH4RdbQfhtQ5Q0Mg+6NiT2Q+FasPB02MabIQbJ1QvhJMIpYqwQtSRpeDVRu/+jvA0nsNf6shJz0igqId+xdwXSCFYpkS5N+q2XV1wsPa3aHUDAkqDLiIwX4+LhhFvTP5bQS7eXM0plQW93KNg0Mqb7HyS8CCj1ak/hxJ2VKRto4Qbafz+TwiOc0p+VMy2pKmv7lhsFUYlRK5jLfzJgoiY/tgSUPkGk+qlN2y7kw86wWchQUT9irEw3Umw/4flixgTqr0H66a27RffhcsTnsQgV5Wh+mrlmQLCoO2X+y5IGEPxo5TOlAGQLRIOgTKC7JxdlkTdrp8KzgZ/K/fHFI1AW9wdbR6n9oIAgWKMzxL2weuwtVOsWoh05195scJQSpXSiTGQTx0nzcHCM1Sbk9kebxvYQsIsanEr4KlxTneHgI9/cCDTQ/17RlsuSEvFLkdW4jkny0qiwlUWfbxevTw2R5Cp2PqeKtKO4wfpVkhd7qAlnzIYe3NtedhwfYEBKp/69iT/T9NWYCs9mZUW6aN0H0Vczcu2m1HBl7K30m6HcLMbBHEMW+Ce8WqUI7n2SBWVbGKTHKgxSLtnnx2sOqh7lMpe5hx57ZinJmcV04Di5MWhoINsu9+4ezW3CiEJLiIIRYKE2Z9Lo0ChhncBC33ImZRxA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(396003)(376002)(39860400002)(136003)(346002)(451199018)(2906002)(66476007)(36756003)(8936002)(64756008)(83380400001)(41300700001)(5660300002)(66946007)(8676002)(4326008)(66556008)(91956017)(2616005)(66446008)(76116006)(6512007)(53546011)(38100700002)(186003)(26005)(316002)(54906003)(38070700005)(71200400001)(6506007)(110136005)(86362001)(478600001)(6486002)(6636002)(122000001)(33656002)(46800400005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?EP7qpxNcZo/j5Y7vMMRJO5heGKcNlm27SmxRtIj0OBR0IzLk85w30Z29xcEH?=
 =?us-ascii?Q?8GPZIW9HpxsIwoPj0BHIfakLfeQR0O3LMta2AicBAz60G5Fpy10aCrabSqW/?=
 =?us-ascii?Q?wY9JHRfPF/d2UZldfL0IAjy/ldxwL4CLX053MKQRy28czDuxlye/Vx5rGE2x?=
 =?us-ascii?Q?jbbtB2jj0eAeQssFmvja8DLwowysFHYj3hhLZiZ340YNXSSQyJ77Bj/YZ5gj?=
 =?us-ascii?Q?9lvd5XDUNylP/be0dvsArVIERe6Y44a2x3ZI66lVJcRKCwUNABKsjZ1NmFU3?=
 =?us-ascii?Q?pwE/MEUo7AU8dDWdLCGN37g+yXyBZFuIqAS0aYJ5FGhNS5eNDVienCT/QCWF?=
 =?us-ascii?Q?guinrJiywl2853sDFVtUFYynUOxzcNW2xcXpvYo3PkJFxA2l87UKBleX9rPb?=
 =?us-ascii?Q?3/PfPuLxwNZvBdZyudWTGtOOSdPIsknQR602i6gapzfK7OwmGiKufMoEnUiH?=
 =?us-ascii?Q?TiBlerz/z8HpMqdLvhtdnyftIIiIiefGl1Cbi17an7YZaudMgB2dwA8y+rp3?=
 =?us-ascii?Q?CetSmtmxAlvSv90+5L8r8Sm9oymCsZ0t4YybNrToXJ7nfc8vfYCs9B55/RgE?=
 =?us-ascii?Q?jgdLp0IMVCmpYgqKw44ZlzZ9iJAKku578k6JvJEJlmy8WV7lIT7TbdG7hvC7?=
 =?us-ascii?Q?xrvgDSF8A16MKFdJRpkBA/pP18maTpLi6Ga2qEE9KiGsEG21wEeXOepIZC4J?=
 =?us-ascii?Q?AxIegi+ei0nEvm5VbzZoTCNxrBQ8VrW30jDOhHAzicezPObqbNpOum80k8B+?=
 =?us-ascii?Q?apfTR9R/sZVzKftsfogzfOAzFS3mOG95DXlBJ/XbQ4sgiNa8xyDcM5Z5KZMT?=
 =?us-ascii?Q?Y9657zxtTZp+PgS01P0Be1atAbkQ2lZYOnu7GzqWxQ6qCkIZoAJi1aepzcmE?=
 =?us-ascii?Q?q6ecHEwzJz1OloVvO3ulxMOCKw/tDMbmeDLNvCkKmhId2KOr24pkmtM+EmT0?=
 =?us-ascii?Q?O0k4f+IoOhLnXlaFIGrvFvqTvR/2flcbVsarCXX3pC1mt8m/X3DVi5AZiT1I?=
 =?us-ascii?Q?6yeCiYcy2UhK8lEa7EyQEesqF+XEscKiDnjdKimncjEo3fVKUytiQZN5luMX?=
 =?us-ascii?Q?K3a9lxQZXrpSH8J1m6EQJencr4f11bvC63TGLmRQkTlal0RGd16P9LOQR8pm?=
 =?us-ascii?Q?9uw7qUtwVnHAoooMbE86+cAGM1uTfoaP+agwIaedSi9GdqJl9ExdS5yOtza5?=
 =?us-ascii?Q?aSpQ7C5FJqSujvGtFHiLFLHNp6FNuwxcGxst682Ymc/fatIKpTA6gc7oyNRn?=
 =?us-ascii?Q?wJ9Vsg2xnNLgl5Du4KF9K9aJjCkbxeXWj3wKo9mFNsHwdlPdmYOxwyOVDe8c?=
 =?us-ascii?Q?O0Vl6G7baH66nHHKWeoJ6/BtQvRu1zi6BWu7AHRBY3RFcX30wp8bRBNSmVh+?=
 =?us-ascii?Q?18Sy9DWI9Vz0yO6MnlzpdMBPI9VdPGx3s3bWriVVasiBjkGnX0kVvMtwI/2E?=
 =?us-ascii?Q?lpPAPhmdqNRpuS5n0IgQyPM9RLUSda53+XBMhKDHqXM+BOKhdLrHMQwiSG7Z?=
 =?us-ascii?Q?3g6ltKAaCyQVvYLFUB7wEI7mCkVeeLq8ARcpMeEi4iZt+jsBRK6F6nqt2HP6?=
 =?us-ascii?Q?Nq7MSaSfPyrD0W+d3NSCv3bt4idHaSye++Dzg+9NDjAaS+2KHSgSNl2rk7dZ?=
 =?us-ascii?Q?lQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <07ED3409A906C945B9B1D5BC730DD908@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: qxr383XOBhSWOJ7vAWlnhrfQlYYRlMibqU6KR2KrSI6VFMLdIoDTlY/lzWh9JGaoj5I/vFXV2GvNQGodrhe0bvW0ZikGZ+ES8AVqrMJEZFHdOVen5Fm1QQbT+rZrPLy8diTEge4fUzsjL3/lhrt0/HRDtHY6Z/nTzNJUZCsY/h9ZXQrZmev0Rw83H+g5zLu7mYx8Wf2+VlMZjXqL+3/sHMyr5lVAHD1jejD8CGqlK5JtMDJziik8PyRKStqX+OCgwXHTKhMvO5K5qhthfGt0VUMAnKl0K9A2BlG0of38Or+BwzKAxDFlmSrcTHrgxOrS2v1mP8k/SJu6wsaDyA/DE0cBeJV1Iu789b3eXQUHAs9KzF4QLSWYf6HUdzLjCnS/U9Xj5UU8TuQyXz3PfdyYD44CaQxkJ5aLGy6xUpSJfbKY1RFewHsEvzz5354c38NYC0HndNqBg1vkUl35ObVjGreuskyNrakirxxrfiFmk/A/u6fQMAUtJDqgEFWAeZGXJKZE6MswSjD79HmSMUhIu6sepuQRTLofWefptodP7Jx7b9ZKXUWI2EH+qxYg3sqx0jhDszirJtXjssPjfBbwnbjGZFI0WUp8dNzpYsVc8imX4CGCwrjEUv4K8TRvqmfc0rfqOIQhbrbJnaJ++CP5iuGKIordZvxYkb7AzBdl3SWB79hqElL/GAexr39eKwjcKg/DBfflzQ4yQX/gGkPTrgTdKpj/OT+Q34niP9xcmlUMvXyAbMLYxQyhOWyXErCBx+okjdDpZ9K3lyQLOs1BSIGN58qo22i8SDfmQOj1skeQKggPFAgl4b/X4sMEuYdd
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e055a97-909e-40da-b13c-08db0555794e
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2023 19:41:26.8304
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7WIiQwd5WanreOb0xwBZwMmrczoC5iSEQPEJ/GxT61OwZ6f1L91zCXFFBCfD/MDkNT5w9Nvr/6ObrFrIry0HiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7513
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-02_14,2023-02-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 mlxscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302020175
X-Proofpoint-ORIG-GUID: lT80qK53PCADbXGYQLeYg98Qne7mY3af
X-Proofpoint-GUID: lT80qK53PCADbXGYQLeYg98Qne7mY3af
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Feb 2, 2023, at 2:36 AM, Pumpkin <cc85nod@gmail.com> wrote:
>=20
> If the upgrading deny mode is invalid or conflicts with other client, we
> should try to resolve it, but the if-condition makes those error handling
> cannot be executed.
>=20
> Signed-off-by: Pumpkin <cc85nod@gmail.com>
> ---
> fs/nfsd/nfs4state.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 4ef529379..ebdfaf0f9 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -5298,7 +5298,7 @@ nfs4_upgrade_open(struct svc_rqst *rqstp, struct nf=
s4_file *fp,
> 	/* test and set deny mode */
> 	spin_lock(&fp->fi_lock);
> 	status =3D nfs4_file_check_deny(fp, open->op_share_deny);
> -	if (status =3D=3D nfs_ok) {
> +	if (status !=3D nfs_ok) {
> 		if (status !=3D nfserr_share_denied) {

if status =3D=3D nfs_ok then status will definitely not equal
share_denied. So this check is a bit nonsensical as it stands.

Usually I prefer "switch (status)" in situations like this
because that avoids this kind of issue and I find it easier
to read quickly.

Jeff, you are the original author of this function, and
Dai, your commit is the last one to touch this area. Can
you guys have a look? The one-liner looks correct, but I
might be missing something.


> 			set_deny(open->op_share_deny, stp);
> 			fp->fi_share_deny |=3D
> --=20
> 2.37.1 (Apple Git-137.1)
>=20

--
Chuck Lever




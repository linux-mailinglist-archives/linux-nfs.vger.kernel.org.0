Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BEFA7DDADF
	for <lists+linux-nfs@lfdr.de>; Wed,  1 Nov 2023 03:14:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231358AbjKACOr (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 31 Oct 2023 22:14:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230365AbjKACOq (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 31 Oct 2023 22:14:46 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BF1CED
        for <linux-nfs@vger.kernel.org>; Tue, 31 Oct 2023 19:14:42 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39VKWOwg001599;
        Wed, 1 Nov 2023 02:14:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=je4PhgGox8/4AJ9zHLxBsmG7s0ItkIqUJWeIkqaPGXA=;
 b=s9R4vq+mOy1EJXjEvOSd8BZG+BZVm7nDTAxhOs3MzKvODZlVbeMxEoWjBgoVToMc/xSb
 0RTP4dl/dFzCPuAtiLU8F+m41NPKpe6iBzPiIAPqCmpbcCL6J9JOexMF47VsVLVo7Q9c
 LO2l9DAEUh8t66EDPptJFkxJZD6dJJZHNVvkFuQpUC0EH5H+4OxyiZl7m47bZTmIRdvn
 BcYrfk9NUWEHJa4qnkKvl6SRgxJzPD0P/3BVlUOO+3nSOrJ5ow/GIb9537jqrPBQbZm3
 caHK2pKvzk6rUQWL+gEyb0YR+EyyQrteTcA4sKX5EV3HxP0GYT6ryIiiyki3hX+390U2 CA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u0swtpkfr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Nov 2023 02:14:32 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3A108Dsi020236;
        Wed, 1 Nov 2023 02:14:31 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3u0rr6jf0f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Nov 2023 02:14:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UBYtWjPuBgXlsOAkaAL+6iW3c+F9eu1hBXcugvKRz5ViTPpSgrrTMvayQowlUwApeUOlXgvArIUp0cwUcd80fOIhad/VDrLJj0aea1tQl7dCgLLB6aZiVOx1DeM6YrMGH42gl84/tRlvfAsQMqhgRFUNXfIyzeYIL2/jY0RzDQ/SeHFZUYbdZDTM0xHbYkPa8nUhmKSPojx1K8ZbeCqP13tmd520j/BOKXETshXs/+/7PAvTJ+oij20z7TS5NTWoU248oPcUaSXE4zw7TDuOgH+wLypOYTemwZ/gS0MzDslDDfrJvNzrtqM0s5jmDV+m6lVXqhU1VZ+jN7PEhOHxIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=je4PhgGox8/4AJ9zHLxBsmG7s0ItkIqUJWeIkqaPGXA=;
 b=awEt4x6Tx8MwJZ65NYIG4FcfzunMB2pojVFlcwih7FmQKmm03TpOu/v/ZhjD9l8hTo0xNkFk2qOumqVxD6N2UTjyWhrbBKFhutRP+960FN4FFboebdRPNvU6tWyRDWGJ2it1nOvrCy26NN8D6yeMQ2l1z9CY8sfEF0MFVyHJ7RgWYKgumYbC5OtIRiwst7MYacwCRfb2XUl5GXplpzhalQ6ax9agYSqx3DIgFzLhpaTYlIa6FWlWHApBkPZZZIC8DlIO6ykW7Y3Tk9XuVf/yCeOiyKb7hyHegCBo2+K5Vkyrwr9KyzfjAxAeTX5b8A5OHMAvnUGsMzmFIFklEeoSjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=je4PhgGox8/4AJ9zHLxBsmG7s0ItkIqUJWeIkqaPGXA=;
 b=cZxAraIKmBTNIa5Ksmcx41ohUCBckBy71v49ZUzkQyB5f1u/ZD1Eik9A0icN5NwtN0TSgPKLWiJ/bZqLv3G0Xx2DinP5MVB3DC631YhbIP8YLOIklsrZhtKZNIz8kv4yIWdiswu9iqvisved32kAEVZXDy07DepAz5q011QDrc4=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CY8PR10MB6561.namprd10.prod.outlook.com (2603:10b6:930:5b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.22; Wed, 1 Nov
 2023 02:14:29 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::3474:7bf6:94fe:4ef1]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::3474:7bf6:94fe:4ef1%3]) with mapi id 15.20.6933.029; Wed, 1 Nov 2023
 02:14:29 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Neil Brown <neilb@suse.de>
CC:     Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>
Subject: Re: [PATCH 1/6] nfsd: prepare for supporting admin-revocation of
 state
Thread-Topic: [PATCH 1/6] nfsd: prepare for supporting admin-revocation of
 state
Thread-Index: AQHaDF73s0OFopx3Wka1T0y0IH32GLBkuX4A
Date:   Wed, 1 Nov 2023 02:14:28 +0000
Message-ID: <E8637B0D-B026-4835-A8D4-946B9542965B@oracle.com>
References: <20231101010049.27315-1-neilb@suse.de>
 <20231101010049.27315-2-neilb@suse.de>
In-Reply-To: <20231101010049.27315-2-neilb@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.700.6)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CY8PR10MB6561:EE_
x-ms-office365-filtering-correlation-id: 76863862-38c6-4bda-562e-08dbda804752
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uG8hr6qJXQc4jLuJh8MyxJ8cpKYfl5+lKGjMkrcv6W2dooT/NMxLj+oGa71ZqLLNqubkl4xeT8PmtCtLImyHaU6qdovX4TejkeDcD69XmeTr1OFf0xR8CKpAIyPytg2XWQy/gKQ+VUoV/hDuIdoTAyL3TA9TsIAzNwlzTZxfOx+rRUbDd35t6k3iiq8pKgLgtRJqCtgz6f6gq6h2Jxt+aeY6UfhZVY0UIuovvLcclfCkv80l3+wiR6Qeksk/WKiQ29MkYmNapYuw4jXoVhwKpo4x+2vFF6HAqh/ykafkoeGgbNujCH8xXgIoZJO/eX/wEEyPB3brljM+NcagywBwfYgBVwHA8CiR0NyB8/lrBGS5akl+oj8d+hyGPtVvLb/olJka9rfcP/dI0D3q5m2c4KVFlk1gOgfALptu2GkEgb5nNSU3FnnYM/+mkDcGFpa6Q5/qKeYa6Hfqg2t9PRM8c0VyftnQzVtdsUnRNsoUKmgGz0nUQpWKs1RkI4Ni4TAxELRaW6ZP24UJZO9jEsmk+wOmn2zJip94JH3H8A9LYMVIY1K/2JT3dWvOWJVqM4o67oUnh2KOiNPK13MhVv05gA2ywf2yLKpP1xKbcIzGh1NKG3PtnalA0i6ag3o38+Sg7UAQDL3J7uZKPnZX6abLwQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(396003)(346002)(376002)(366004)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(38100700002)(2906002)(33656002)(83380400001)(5660300002)(122000001)(38070700009)(91956017)(2616005)(86362001)(6512007)(41300700001)(66446008)(66556008)(316002)(66476007)(54906003)(76116006)(53546011)(71200400001)(6486002)(64756008)(66946007)(6506007)(8676002)(478600001)(6916009)(26005)(4326008)(8936002)(36756003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?TojYN9hm5GDGP8AS7IndM78gqg1mPX3ygO/Bbt6WI2ejBlVX3xA1HPLjkeaX?=
 =?us-ascii?Q?tYdYQvWFPuiNikknJ25BM38la7cTTUEOZnvF0DoKtytzRk08EzO+11lvL4kF?=
 =?us-ascii?Q?8CpQx7xAbz0CEoNELdvmonwy6oR87vYoaARmf18LV2zobXTLceDool9JRNzi?=
 =?us-ascii?Q?8sRxxDGFaVgrdDmWnHp68+Q4L3Ycurc2b/tlzu/S9xyH60KmPQnv0n69rRKN?=
 =?us-ascii?Q?Y8ik7p56fdSLgv2K0N0GiVrZE/ZQNvjgQ3i8Y1FHswDPMyZH5xI2sTS6UFUg?=
 =?us-ascii?Q?gJz/O2v02jEu9W4TSar8iP7kNuva9xticlBFOc6QQwQzleCWpSXAnqKg5WVO?=
 =?us-ascii?Q?T4PCNIFGvXQVDtLCTNL5Y0pPCW+nEOYfFYr39uatDgCm8ZyC1PEIkbOKQU7X?=
 =?us-ascii?Q?ytpI11Dd04SVYOezeKqU546xRg4hZTfmFarv94TtA/ku/t/QpXYwl5nIU0sv?=
 =?us-ascii?Q?RoLxf9hEOiRi+0xgaw7OPz4KVJvH9rE9Aj3hVFpd56wyXMImVhToJ9bDEVPd?=
 =?us-ascii?Q?j18rbjgfiSp7ydr6yFSUHs1ah6jI0aP674Q1bsZJWd+KOFF42U36+onqhmI5?=
 =?us-ascii?Q?qtvKBt5DKjAyLaVo5dBaXo55T2SzOq7XIkhIqJaBoH0NEFpcbNK9bgWjRMaS?=
 =?us-ascii?Q?5QzzCh+ZTSR8Rsn3eNwBNgahhSJ2gUcGK2C6jDtMtKon5M9wNSOApm7dmA2T?=
 =?us-ascii?Q?UfJgQ6IqKvYloJioHOG1gAfajzgaSvDSznOpvOWTY6p9wN1LO1IHPjIgup3z?=
 =?us-ascii?Q?VfuFsNmIOLpN1NaN9MQwoR3hbuosbIPfeu2hMOT93my7yoitICSsGYzpqk+A?=
 =?us-ascii?Q?kGFRkMwPZP8rmjmjfKpgmA+oW+0CNCaiz2i69wnFe32JUsqr5zd5bNySv1Tn?=
 =?us-ascii?Q?JZ+p0K5DaWI7e3jDVXwadQRX2/WDcymzfCtXNMTTVSyInvCmuTtRpYr5aCoz?=
 =?us-ascii?Q?jEsoIBxc0ivuSvL7fgYVHQ5M/ephM5DuyWR4VMC+sYga5hGL4ubZQMasA3zv?=
 =?us-ascii?Q?W5uEgCQJ2v7+G4igFhHzTpW4eydb1NAfGz+22OcZkLqg2v5zWsQh6xIxAI9j?=
 =?us-ascii?Q?oRNHjI9d2Hqg7cghvAHQ1RoiuTbPwjMKLnNFJig0ZmaJFGc1mIGqHexMHD7G?=
 =?us-ascii?Q?OHZtUXMRGmiVykVW1de8aA39OlrzoMwgbKws2V8Hxi7Z5WOF5F2+VnI9vs5J?=
 =?us-ascii?Q?YuZ2AbqHo+kemzmvncnziYgaewWDU0T7Bc4bLpK78EJgTWdnsvpnmDo/56zG?=
 =?us-ascii?Q?twYj5+LIfDuFAGHdHoiyKCJXUAVTpiMsVlw8ZHX22WjYsBQrsVBlVgmuoacw?=
 =?us-ascii?Q?LycolI77/b18JGwNqVemJ+7PtmU6Mqu2c8Ol57LSUZRyN9LSK9q3uNifnleO?=
 =?us-ascii?Q?8RfeFk2f/6sXzdE7tehiyCZSHqS7/FtLBUXMYLJW/Mn03neVIq3CTQX9lho1?=
 =?us-ascii?Q?HXitQMtnQJTbi3HDrFEhx3bfaJ/Fw7uiSdi65hC/d1Y7C9hfwm4uj2jhvDLZ?=
 =?us-ascii?Q?T5E/eT7aziLi7frirUFfZ539Hsd/b3OB6RjFBxrHHA5V7/2obt+X8kcO1Ikg?=
 =?us-ascii?Q?VqExQUh+3xlUJotiZvMb/W2a1e90bsw6q2cTiqilRMzQ7BDp6EvNNYtR0fzU?=
 =?us-ascii?Q?ow=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <BA88AA9C43BD244BBF6C16C1885478A2@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: l2upg9n5oyH0gop3yfXsxEoIex+SSr/gDNutwYQEVlSUabBn2OlBAaFkVEKxsoA4m/0TgGI5+76GAyse6o6xAAsyiv3HKaARcaL+aPvv7JMXMdsD48n2elzdD26LFLYggyAAKNWEmPkPTOeXN+8yAAS4kWGOsUIXPOQsFNf3HdBrOykPYgbPkdKjTBA4e5zklbzUtBGTVPvx9miHIOtubJ95TVr5feIvy1VDijT2WbsrBizovocIZDLmCsFaQnBYHaiDkmzkgK+rWW7T2j3gZT67+IMPuiM7WoOKba+Qjme0e/jqcB2Kn2mXMl+NpXxKEjfjM00isW0m9XkfEJj4spB0HDfBnvMU0XpEaeXfzLki8mNibRPvTvwVs+vny9zMqGXxTWa8U0ODv7Bg0aaUf4wPAPiSvc0GZbm2rxbsvfTUo4IXiqLu9yN9plvp2GwYA12/Bg3rgaTqqabWhEoLjgHp5AWPP0z7hMxnVkxJpz50nzwzrlHeD7H4eSnj9CGav1hXwKBQNiY/ouWrvCNrsaH5s1SNfenijfRxvW1Mil7PtpgrvnoSdiiQTQ9C5A9hdRytDdodyY17LjrPGhbd5IXAzZd6VgU5soZ1MW2ZycJ0Oihbu5qm1WCcLF5h1NAOdt/SyENBl8NpAlIe/fvBOzrgHEhqx5da4RyccM5f1+Y+I+O6nUKBIklhdRdp6TRXblpvgdRbyTCxEJnEqfXOUtV3sO4jzwVURDyd+csOKuLqjxDgj/Ph85cLFvioedZGxWJ/nJ77i6rcGUcqiYgpJlnJEz2vv1heqO9eU6e7MS/ZrgJ5ru6x2zlr9iBbWvUhM4eHtKKwx+IYztuL5M4Zt7Yz56XQ1A7DvBUl6t0jle9yyyeFrEu4StZu9PGAlKTN
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76863862-38c6-4bda-562e-08dbda804752
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2023 02:14:28.9898
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OE34/41eL1Xf7PUi7+N7vES+1k+jHyfe8c7mOfTJ0GVKOsgI5Gckl5rZmx4BHTaeYoHXE4eFpamQxYDMO10ANA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6561
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-31_10,2023-10-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 mlxscore=0
 spamscore=0 phishscore=0 adultscore=0 mlxlogscore=892 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310240000
 definitions=main-2311010017
X-Proofpoint-ORIG-GUID: _3KccZOvcEh2RJij9yaAtYERroyFRfLT
X-Proofpoint-GUID: _3KccZOvcEh2RJij9yaAtYERroyFRfLT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Oct 31, 2023, at 5:57 PM, NeilBrown <neilb@suse.de> wrote:
>=20
> The NFSv4 protocol allows state to be revoked by the admin and has error
> codes which allow this to be communicated to the client.
>=20
> This patch
> - introduces 3 new state-id types for revoked open, lock, and
>   delegation state.  This requires the bitmask to be 'short',
>   not 'char'
> - reports NFS4ERR_ADMIN_REVOKED when these are accessed
> - introduces a per-client counter of these states and returns
>   SEQ4_STATUS_ADMIN_STATE_REVOKED when the counter is not zero.
>   Decrement this when freeing any admin-revoked state.
> - introduces stub code to find all interesting states for a given
>   superblock so they can be revoked via the 'unlock_filesystem'
>   file in /proc/fs/nfsd/
>   No actual states are handled yet.
>=20
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
> fs/nfsd/nfs4layouts.c |  2 +-
> fs/nfsd/nfs4state.c   | 93 +++++++++++++++++++++++++++++++++++++++----
> fs/nfsd/nfsctl.c      |  1 +
> fs/nfsd/nfsd.h        |  1 +
> fs/nfsd/state.h       | 35 +++++++++++-----
> fs/nfsd/trace.h       |  8 +++-
> 6 files changed, 120 insertions(+), 20 deletions(-)

 ....

> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
> index f96eaa8e9413..3af5ab55c978 100644
> --- a/fs/nfsd/state.h
> +++ b/fs/nfsd/state.h
> @@ -88,17 +88,23 @@ struct nfsd4_callback_ops {
>  */
> struct nfs4_stid {
> refcount_t sc_count;
> -#define NFS4_OPEN_STID 1
> -#define NFS4_LOCK_STID 2
> -#define NFS4_DELEG_STID 4
> + struct list_head sc_cp_list;
> + unsigned short sc_type;
> +#define NFS4_OPEN_STID BIT(0)
> +#define NFS4_LOCK_STID BIT(1)
> +#define NFS4_DELEG_STID BIT(2)
> /* For an open stateid kept around *only* to process close replays: */
> -#define NFS4_CLOSED_STID 8
> +#define NFS4_CLOSED_STID BIT(3)
> /* For a deleg stateid kept around only to process free_stateid's: */
> -#define NFS4_REVOKED_DELEG_STID 16
> -#define NFS4_CLOSED_DELEG_STID 32
> -#define NFS4_LAYOUT_STID 64
> - struct list_head sc_cp_list;
> - unsigned char sc_type;
> +#define NFS4_REVOKED_DELEG_STID BIT(4)
> +#define NFS4_CLOSED_DELEG_STID BIT(5)
> +#define NFS4_LAYOUT_STID BIT(6)
> +#define NFS4_ADMIN_REVOKED_STID BIT(7)
> +#define NFS4_ADMIN_REVOKED_LOCK_STID BIT(8)
> +#define NFS4_ADMIN_REVOKED_DELEG_STID BIT(9)
> +#define NFS4_ALL_ADMIN_REVOKED_STIDS (NFS4_ADMIN_REVOKED_STID | \
> +     NFS4_ADMIN_REVOKED_LOCK_STID | \
> +     NFS4_ADMIN_REVOKED_DELEG_STID)
> stateid_t sc_stateid;
> spinlock_t sc_lock;
> struct nfs4_client *sc_client;
>=20
> diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
> index fbc0ccb40424..e359d531402c 100644
> --- a/fs/nfsd/trace.h
> +++ b/fs/nfsd/trace.h
> @@ -648,6 +648,9 @@ TRACE_DEFINE_ENUM(NFS4_CLOSED_STID);
> TRACE_DEFINE_ENUM(NFS4_REVOKED_DELEG_STID);
> TRACE_DEFINE_ENUM(NFS4_CLOSED_DELEG_STID);
> TRACE_DEFINE_ENUM(NFS4_LAYOUT_STID);
> +TRACE_DEFINE_ENUM(NFS4_ADMIN_REVOKED_STID);
> +TRACE_DEFINE_ENUM(NFS4_ADMIN_REVOKED_LOCK_STID);
> +TRACE_DEFINE_ENUM(NFS4_ADMIN_REVOKED_DELEG_STID);

This is a bug that pre-dates your change in this patch...

Since the NFS4_ flags are C macros and not enum symbols,
TRACE_DEFINE_ENUM() is not necessary. All these can be
removed, rather than adding three new ones.

I can fix this up when I apply the series, or if you
happen to send a v3, you can fix it up first.


> #define show_stid_type(x) \
> __print_flags(x, "|", \
> @@ -657,7 +660,10 @@ TRACE_DEFINE_ENUM(NFS4_LAYOUT_STID);
> { NFS4_CLOSED_STID, "CLOSED" }, \
> { NFS4_REVOKED_DELEG_STID, "REVOKED" }, \
> { NFS4_CLOSED_DELEG_STID, "CLOSED_DELEG" }, \
> - { NFS4_LAYOUT_STID, "LAYOUT" })
> + { NFS4_LAYOUT_STID, "LAYOUT" }, \
> + { NFS4_ADMIN_REVOKED_STID, "ADMIN_REVOKED" }, \
> + { NFS4_ADMIN_REVOKED_LOCK_STID, "ADMIN_REVOKED_LOCK" }, \
> + { NFS4_ADMIN_REVOKED_DELEG_STID,"ADMIN_REVOKED_DELEG" })
>=20
> DECLARE_EVENT_CLASS(nfsd_stid_class,
> TP_PROTO(
> --=20
> 2.42.0
>=20

--
Chuck Lever



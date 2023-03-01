Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BCF86A73F5
	for <lists+linux-nfs@lfdr.de>; Wed,  1 Mar 2023 20:02:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbjCATC5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 1 Mar 2023 14:02:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbjCATCz (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 1 Mar 2023 14:02:55 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 983DE5FCB;
        Wed,  1 Mar 2023 11:02:53 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 321Fwkrm017202;
        Wed, 1 Mar 2023 19:02:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : content-id :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=r3/6sSPbRb55UlemkIO6Nvfohx5ym0Wj09QI93mN0/Q=;
 b=zoToOKGw+8Dz/Vue1xm6RGvTOrYXoXOwlDwWclJSj7NwhVTQIYMpoG/1nknrUbeZY/zD
 g+dlNMEBxIAWk8Cz3KcrB3MLs7Q5Am51EN3TL0Bbzagum3C8MtFqXxmVL+Xkz5ZK7qwd
 5t2ISqZKFZVVk3xUiT0U96L4+eH/+HW2cd2qKQgEGGraRg77vMKqFKR4RlzxNuzkyWQi
 tXrXShhragFKNRi6YzNcpdGNPS2owrBLLE5lgUd4tw5a2k0U7wZZw+2c/J0tuLXypI1L
 SQNBYqPF+oZbFr3XldY7vN9ev2SORrEHCD2TqRJ3r8a6eFzpnF3fi62BHMC09Gp/Akva xA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nybaksusy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Mar 2023 19:02:41 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 321HTdH0032918;
        Wed, 1 Mar 2023 19:02:40 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2109.outbound.protection.outlook.com [104.47.58.109])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ny8s8xh5b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Mar 2023 19:02:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bY2J8bbMr4b5q1UIkF/hssRAfYjvrg2vwmzUu7cV/RaGRuMFmQhgn8FQTADlOf0mPW2bN9tQlq/dLbiEem5QDvO1RZfHmAp5sKUAoJogI8eA9GT59cgm++2mJXV+e4ay+72/Dw7VkKYkL/Zet2ssTQ/7C1HJywXhQSuu9hl++svyUaYM2Xo5EugyGxAZswbr78CYMQ1NA0Mj865n8EkB9LpMb+5HzmwM4Rr+bgslkyTVnFELFql5N8KkrvuXMbNYM0aSC8NfX1YIvFSEunQS4PoED9ccZrlMPHej0/xSdHvBno913PzW2+e76E7PberkRk0K6vlrF25ZmXeb6tApRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r3/6sSPbRb55UlemkIO6Nvfohx5ym0Wj09QI93mN0/Q=;
 b=JkZwwFurBHL4fPyb9kLoRrRO3C9+eJen4dzdY/xw7EueZkBkF4tGVtCPYwJQJklqHb7i7NDattR40whYVqj2NKikt5+G1aKLScdQtQWbCAb/O9/cMgkftGU6kql0ook7gWbZgCdJCBjLffrKamReZXlJiZvEbi6Ivps+1APv/vuJAZA6a+vDnIdbFuaA72hw2STMZ+A4QKjCDlGBAhH9zhUrFQ22SPKLJ6JRIlWn6HOu/zI+r8Ovf2ynj0ZG/bO4QVZ1F+Az3rYqn/UI01RKQW0ZUdiLvo+r8bVLRX536v23mc0PRfIsyI3c7j7Mhe5DJoCCq3q49s0wK9GHayH9FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r3/6sSPbRb55UlemkIO6Nvfohx5ym0Wj09QI93mN0/Q=;
 b=cOoD+YwCnB7sBOBIpdHGQCqm4AGYzbJR7GAgHnrBYI1PCtbstAG9ZihQ+Yr0vwYODR4IJv0gGU4JLb1f1BLWRSPN7yG6XK6sBqqGtN7mU5Sf1W97abuQO0iZ8t8jBcaNG456lCHAn/pBZhxctjyYXpSqsApZW38NpCukJMzialc=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH0PR10MB4598.namprd10.prod.outlook.com (2603:10b6:510:34::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.18; Wed, 1 Mar
 2023 19:02:38 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5c2f:5e81:b6c4:a127]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5c2f:5e81:b6c4:a127%7]) with mapi id 15.20.6156.018; Wed, 1 Mar 2023
 19:02:38 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jeff Layton <jlayton@kernel.org>
Subject: [GIT PULL] a few more nfsd changes for v6.3
Thread-Topic: [GIT PULL] a few more nfsd changes for v6.3
Thread-Index: AQHZTHBjtmCKZi1x702lTttHOsbv8g==
Date:   Wed, 1 Mar 2023 19:02:37 +0000
Message-ID: <B67BC63D-90D6-49BC-BEDA-92A8F9710052@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.2)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|PH0PR10MB4598:EE_
x-ms-office365-filtering-correlation-id: 870a6fec-79ef-432e-029e-08db1a878665
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZP2rMdt32D1tW14uVhj/06O12IBkajQEnw0ymfjwfflHHTdSn1nPbCgycVY/N3Ksh4EQdaZgjUMYHAcn5FLUH3R378zqNoTZ3yHX3OGaTooa5n6vDRNikLNuoxmvsFB/IrxB55d2RfyoZgzgqN70SASXJqhrKr1tFWz6ZoWY2Z9YA8ML5+MaeymNFgHQ15BAY5pkCCHN4SIzf0fl1X0ZAWh+iT3oGxmxEzlfugSqkWKwFxsnm+GqSP1C4p1fMXn1i/8JNOchOOD+nT+3/zhGOaoT35nKVxmAqshWt9V4AB/8DPbni9hPbW7+FDJoOmy6vyoiZUJzgBnIcGcBOFW4DwDG/Taq9iFnW7THNQgaDH4bmEk2U+4w9WKMEMM5Fb996PTINEtb/DfyJ1XfixT5QAPOVYQMrLnTzMuWpsC0WSXymxDyyos/+XwDcwk5mV+Qky/64k+wVSgx3UwmYAhyM2M0iMjFWBp3JnBgDLcyRQerMMQkzls/gHsb8I+F8ANfoFnMbdcgvhRgWk6iGWUsY1bnZs+qd8M871lAJxlmNwH0RptxM2A2crML7+jXma5MuSBR2QHwVWadkxeRarEDNon+RETC1p2WmZaNoK4hCp8J6+pEKwn5eXEqNe/OSvbQrS8v6DVYIxwSptjUEyT2Q2lMbyUgx/RGIOT5zvOS4ZY5Tsfxo4DpNfFzncAKOMYlcvgBAoswomZC94YYic77hNBv9dUhKa7Rg8seeiVfyt4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(39860400002)(346002)(366004)(136003)(396003)(451199018)(33656002)(36756003)(54906003)(6486002)(966005)(478600001)(8936002)(5660300002)(2906002)(66476007)(4744005)(76116006)(66556008)(91956017)(66946007)(316002)(71200400001)(4326008)(41300700001)(64756008)(6916009)(66446008)(8676002)(122000001)(186003)(6506007)(38100700002)(38070700005)(86362001)(6512007)(26005)(2616005)(83380400001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1aQycNaGT2Y6sJiqarXQKCZoZYnnDcExQ0aKf4zuT+l6xTmW18G6Be2xJcKd?=
 =?us-ascii?Q?MQ+2vT3MpqDpYTspahtC2M9Gy4Li1TJzRyFMhlzD+Zmx5IDzCVMc2zgPiZzr?=
 =?us-ascii?Q?rQQATyC6pL0AztcCj7ocYWLU0XZvwp5tUYhGLrOSNzkJ5rd3fpeGBPYa1BHt?=
 =?us-ascii?Q?RP77LwNkNYidRytU3Kp3L7ogDHXrhtc9O+MX4Zc9Gvrvg4VrlCiMz0x4WYF3?=
 =?us-ascii?Q?LkWg0Dipb/IaVs/rRb0mdkQhzLAvX/oPJfQOE3p1fDc6YT6UyhJvtKdlaztp?=
 =?us-ascii?Q?qng7n6+FVawxwhEtMZOqIxpykOWFjJAt/6nVbMCs7k32U6bq7dfFHdWETdrQ?=
 =?us-ascii?Q?cURZdtTTp2rmLB0AS4Hozg3JRFvcFwXaB24OZpjOvbZ0u5Rfq8iCReuhYhOg?=
 =?us-ascii?Q?KEQtbrEwYZjyVEfQtuhzgTJ5u2heCKv5d25ybdeLxFhFzUNN1VY3RncSTPY9?=
 =?us-ascii?Q?GokP1DyMxAyNUqASQcdObvLupa104n+/lN2jRajlLLnDcX9/F19M4Ul5CED/?=
 =?us-ascii?Q?eBQZgEb7i62HJi+hNJ4LIErJdIRsSwXW8kF78dCEFKMtwEBlhlyKIXzIWadX?=
 =?us-ascii?Q?KWzOPa2FOmi5YGkTzHNdaZ3orz+oL6ZRHf1lcTYOwS2XlQaqrZyznpctoNdO?=
 =?us-ascii?Q?21cO7KV+HMArXYbUxdlxEhNy5APOfyl5s3WguZEm1/LOMprbybE9AtGSeVKT?=
 =?us-ascii?Q?X6DMwRFfX2V/BUSwAHBCQoaUorg7yh/m9LaL/ShFZoUnUfzaA3X7434yc5k3?=
 =?us-ascii?Q?qLPYi+3ZACiLCu71Y6A9WaG7WNaIBGP533/pLKu5A/Xjv9l9ZZrVqAtOj53j?=
 =?us-ascii?Q?HC97TD8RzGgx67olTe6bpV86fl4nAxxMI6biA2CinMIgoTBmKUEAK3aZZrZN?=
 =?us-ascii?Q?apf0/4f++NJFROJxDhB9OF6Vt3uP7OPryXRAc9qPcpGxm9RKDDqWogId0bnX?=
 =?us-ascii?Q?iJ9PoaUZsb30liWWEjYGnuXAIdMFvG7jcxJyMDnuHOVvThkvsg1V/hr8+NpR?=
 =?us-ascii?Q?2PWOy9S3hLcnUuF5CSHucTEOJaDt0Yt6fvqzk/XX8qOOGEJ62d6v5AV5UwQO?=
 =?us-ascii?Q?478YoK3GnzxDh1XMKT0XZKveX4LYGzBnyKP+yFZOnEAbxga/5fcT9pB9+18s?=
 =?us-ascii?Q?bwq6VAgRNX+WHtbxgvH6HdGIefT6g5Iv+NwYDMIREjDvhB5ttMgpRcS7ga9Y?=
 =?us-ascii?Q?B/uhsiTLKp9gtQ3a9B0CSGfl10lOVUhmj2RqszDKDTW6zUvCILFdFGr/ru62?=
 =?us-ascii?Q?UjofgJOUpJHFYrPzSyLCGhXOCeqx4xpuOJGTDEtlndBFBY3ecZJY7IcVHyHK?=
 =?us-ascii?Q?tlXUW7hyzIR9ZCgp27tZUo2z+6P6py4ByiNtQ+BJRByktMC88CiXekExsvLs?=
 =?us-ascii?Q?pK6Mu03Yg+suvXX+GbfmJrOF6mOH+2nGlqb//ksvYHd0QuBhxh8Yq3/DMaU8?=
 =?us-ascii?Q?tcSp2TcD8gP/amVqKYQsYvEtGUqXYNDFreHEO+Uk4S1bU1JbeuXgXy9YKHxt?=
 =?us-ascii?Q?SI6FZXRSSZ6al4sfvpuVPOS1NlXWkQXFmj5y8bdZSklnWN5lO2azGSdD5+be?=
 =?us-ascii?Q?7/rqhlAsQcw7G/qtLFyELqjG3zkWskxASwJdSyezJdUUQgbi4Q5lqtjiTrxi?=
 =?us-ascii?Q?ew=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C38F8670525CB045ADEBA50BA72B4D52@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: CmtzYQLexTHEl2jEKuqSLPgD3NfuskBTi9XICUp5aJEpzlhZQ+uqDBeEGo9qDyWGqMzdLp7STW0vB9c2k+U4PmCXMjOqRARWuUd5Xd0IFtbr2w2jJYzDVUF3nKpYJX5V9THBXaGotqqUE2jTrOPRGIk7re8A5azMmCyTL7cnS7CjcS6PgS0MwiU82+36jWf3Juf9IAPD9cFhRPu+xtW/eHxnArDUVx1+7badOIZkC3N8XiIpypC3MVbtYlUA1h1JJGjmOo/+HzS/cLDTtgFPZ2noyhr+xQemACyjKPWVbo+Qu/uR4U0zhblY+r3AS3KEGTW1CYJ3k1/bcIdfQ7vxztqo4d+odVkqbZknCKSicsueDXE7aos2+QAoSj6ifZlN8jcFAoXOpWfRG1ETT4MioJqLZCmxhQIaePmed+pS/gqO8szlZ1H9GtDN2JKgG3RFvcTJU6/AmOow77J/7Zw7Org+tiSZomCEYEOZBZ/peG3IJwNHd7LXazazZb0Beltgx0vaFQEk4CI48pnaNhv/ISQowvATARnbgOAtZXxD9cM9DCw2ivNlLyNTE6JcdblTQ+B/i1tyBD2SZNyFKdPe1Qk2lmtR1QZthtJq2vV3m4YfnCe5J6lXWbEJWCvp2TREA6AgzsdiuL+1c0RBmH1+e7geYLhPxZjF9Ww5JdIVDWoxvUkehy6O31pRj4ebGM/AskwJor7P0thRi0YA8D7+Kr9Fkvw4j6Ny3rK4+72XCazbUYlxhTHpM1Fd8GRwNrn262/qptWSJ3v9bw72bJfFfmgNYjEzRMm6sTVXABv/1blAzvi52zyg5GowLZQbW3FlehinZsGEkLF0p3A7yX+bdQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 870a6fec-79ef-432e-029e-08db1a878665
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2023 19:02:38.0262
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SfPJ+XMZaqKbKPTrcSgiJKBzJAvUNNEvjvYr00Z/BE39eyQno0e+ENd1GghOuT56sVFBPQCsrQ4pQWZs6lVLyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4598
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-01_15,2023-03-01_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=980
 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303010153
X-Proofpoint-GUID: T_EgnwfDbpNXdM3XtnnP-zcz8AaVXsuC
X-Proofpoint-ORIG-GUID: T_EgnwfDbpNXdM3XtnnP-zcz8AaVXsuC
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Howdy Linus -

The following changes since commit 4b471a8b847b82a3035709dcf87661915c340c8a=
:

  NFSD: Clean up nfsd_symlink() (2023-02-20 09:20:59 -0500)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6=
.3-1

for you to fetch changes up to fb5b855d9f34927579baa0a20b4d0d8ea3740abd:

  SUNRPC: Properly terminate test case arrays (2023-02-27 16:27:51 -0500)

----------------------------------------------------------------
nfsd-6.3 fixes:
- Make new GSS Kerberos Kunit tests work on non-x86 platforms

----------------------------------------------------------------
Chuck Lever (2):
      SUNRPC: Let Kunit tests run with some enctypes compiled out
      SUNRPC: Properly terminate test case arrays

 net/sunrpc/auth_gss/gss_krb5_test.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

--
Chuck Lever




Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFFE37B4212
	for <lists+linux-nfs@lfdr.de>; Sat, 30 Sep 2023 18:23:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234495AbjI3QXJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 30 Sep 2023 12:23:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232221AbjI3QXI (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 30 Sep 2023 12:23:08 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE4D3D3;
        Sat, 30 Sep 2023 09:23:05 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38UFjqUj017184;
        Sat, 30 Sep 2023 16:22:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : content-id :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=5Iz8jML64u2m2VynOM0yih+18sbHkC3u3YT2D9SAn4w=;
 b=ilOo2P1geTnkcpVtgKQvye1HznflCa/z18Bh9Qu+TY6ZoWr8Bz9ZAe0u0puqX+gYjloO
 wAJijd6hr619g7nZpN9yAmCcKoiKbRHPktSsi6E29PCfSK/BOCk1z50hpRWPmky1NUZM
 sr+IKzgYpkS8xoOUOcUiGJKllygT6i+dT/ujbzuoIEy2TKG50lSPL5BvuMNhXEivkXJa
 Vrgra2EraWXCqXh09ESVFMUgs4sshT3gFscxagX643EHO5Uf1KrhW9l5qdR/pHTjoDxv
 meFKBjG9oeSIaCBPtZkjPc+8dcLDWX6Vr6ssCgODqEyKQvGneTSxcYZZsjUDG4+n8Man vQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tea920j4v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 30 Sep 2023 16:22:54 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38UFdHib000692;
        Sat, 30 Sep 2023 16:22:53 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2104.outbound.protection.outlook.com [104.47.58.104])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3tea42uvfj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 30 Sep 2023 16:22:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VGZoCuiTM1VI7e47ST999I7mH+d4GuQEDhfkuJoYMD/QtF55LodWlVAVd2aMlAJaTGXKY8QijRxeG0HxlcKsLw96Wr5vAoFsn4OcTmvlTJulBMSgH17HMkOwG8gQlQVK1c3c40GkTuofCB1g0r4YUydqNc0hpo7HkNzanvth3Dzrkvdp3EGMWdA4X5JWIqb+ncjMkYLQHo0w+JNlvffk4/oT4tQS2s77dNe5RhYrnlvTSbb1HAJuA5Y0Bu7rXsMbdIZCjQ2KCCK8HGqkucDDaAtjH6aus/9QTOeGKoUjC71sJnC9qCwhjy/cjd8K86rH+IVKeV1i2C9bxShApWMPFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Iz8jML64u2m2VynOM0yih+18sbHkC3u3YT2D9SAn4w=;
 b=PMrk5J40rqJhatZSHA8+EFPmt41scGn1eV2D6VEdD8oPWImXJfcAwHejx4IpxD/8QDrAheRY97RekHbAb+uTecOrBDY92DMKySVc2koKyr6ZL+r9WUiRU/15+QUljpBD8SmjleqSJ0EuglTirYabQ3+0biVKfmTHDSHBYnwi0F136nryBFfITDdJAuOI05Quf6ZfCxekzqwY9yidH5FlO4/htAFzrgtRXHD/fTqCBuqUX64eTyrWFMF0Zbn6WtqQA3yC+80iaYdNHne2gaulehsYdcoDUmh9TYsLtN9X9gJ6Y44+CL+Ni1KY+U+6GN1YtVWRjVeyFkeRvzP+9GuEgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Iz8jML64u2m2VynOM0yih+18sbHkC3u3YT2D9SAn4w=;
 b=hAXmSaR7jeKE6QkIqyBDYUyZzoCd+NLpcIxTw1HgJLuOEfWAN7WNsbbbOY4DrxcHevmtiHLBI18+/2YdogQTSQ0OahunpDIWzgwaoqI9n37HIyxzJECKvTEpesvWGv+Lo7wW4YDAh0pUm9IIOnKanSRdvsBcl15MIfucSc50qj0=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ0PR10MB4479.namprd10.prod.outlook.com (2603:10b6:a03:2af::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.28; Sat, 30 Sep
 2023 16:22:51 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::bffc:4f39:2aa8:6144]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::bffc:4f39:2aa8:6144%5]) with mapi id 15.20.6813.027; Sat, 30 Sep 2023
 16:22:51 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jeff Layton <jlayton@kernel.org>
Subject: [GIT PULL] second round of v6.6 fixes for nfsd
Thread-Topic: [GIT PULL] second round of v6.6 fixes for nfsd
Thread-Index: AQHZ87pbPCQhrGyJvESRlWH3vhUYaw==
Date:   Sat, 30 Sep 2023 16:22:50 +0000
Message-ID: <857386F1-ED95-4113-91D3-C082C39040FB@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.700.6)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SJ0PR10MB4479:EE_
x-ms-office365-filtering-correlation-id: 0f991a31-6c03-4f16-e6d4-08dbc1d17e0e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Tsf1KOHfswd8NEQRwLK4iuIGOIFF3Hr1q9bkS4L7p4/SBlKEmTQzCXp+oTyfkuvIRevEkfqANwfT1Wg+xMrn5y6gntDxxZvto+0cCsxpOSc5XCjsVDTorGDxmVgnISjDpD46v81KGEm8ncx9nKxnS13k+UAMygn+g6PXwHqkHCQhEQTQKHlqISyO18k8cPW4qxdX7Ag4iXa8R12s4tu4UbW9nxhbM6uyYiWRL+e0a1I2GJlLeKR+KJ6PQkWlJpqpivbbs4lq9uZdqZin3L97EdTD3HOUGhGo6QjrTJ6qf0dJ6oBUxMXZOu1eaAQc//GBEWfINeH7yNzZbN5V/9UV/2efgkR/SjTxw1TQNid2gruyZcVbnkDbz6y7FfsBszbOEcbFakiLa8bb9Pix9BmakwSy+XruXf+T9fp44QokfZpsIE7pdJqt9tmv3B8tVJxea1JFqKKEwY4SQJSKVHxxbn1pFCfu4g/gkH8ioQHcmlThPoC4O123sjhCQfvskC0QgvmVdrx9360lCkei0NCfZp/2+g7jP3kJ3Be1RLktB3kmcajv4Znqme9j6LxFkU2kXCfIbwIMIl5krS6tRmbhP8dERuURrl/CnndfviOQu3H+iQey3EnVhsFpPJai9cnt1EbjXGg2uhfiKnw1KuK0+A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(39860400002)(366004)(136003)(346002)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(2906002)(71200400001)(6512007)(6506007)(38100700002)(38070700005)(2616005)(76116006)(66556008)(6916009)(66446008)(33656002)(66476007)(64756008)(66946007)(86362001)(478600001)(966005)(6486002)(83380400001)(54906003)(91956017)(122000001)(26005)(4744005)(36756003)(5660300002)(41300700001)(8936002)(8676002)(4326008)(316002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?dl1vAf4uivEpWERT3UDPxrwDGLaSRrj99rNXMAJq/37AO8NGJNPnYj0F9PTR?=
 =?us-ascii?Q?/sKeDGOexbiOaHQsgl/GfqItq+MS0Xw4kkU+BvF0lyipuIjIIhj5dBrbWN71?=
 =?us-ascii?Q?SyjZSG7X9tziBKn9yaXwCkUaiQY9uoQJDVC2o6ga0TJPKv+POTADrJeHNbLh?=
 =?us-ascii?Q?AeR/WkxpRCnwuyHBb0WgJa43sLIcNQuM7ZInmwUBjyrfJA05tgiAlypn35Ng?=
 =?us-ascii?Q?Q3FnQt6L5TziHJeD7sEI1WKnvIQG5+2ziweJRtBw5mhxFRhTKCJVj0B/ZQkq?=
 =?us-ascii?Q?20Ii8+y7m9m/xQ6puBjs4nMKGlUXkbNKl4iF2yP3sgzuaWEeGEhECMha9PTR?=
 =?us-ascii?Q?O3U1WXdkRGP5dykEzw5K4rqN4IBnwT+H8iBuQmtc//3oYJro6jw0v8Fvq5Sd?=
 =?us-ascii?Q?t33YuhH4cKAQEgkZT2BUEoqH7CB531G4I+KVslZikZIGw+tqFmsHdp8nwlYF?=
 =?us-ascii?Q?OPXRTEehW1dVFjwBjKUNPUN10aROjOy/WQPfsX1rU5gp0E17K5Tm81OvZ7lO?=
 =?us-ascii?Q?PgitpFbXQx0rpLT5/gTVSWzZ1x3yCWsmcC5RYlCQHitk3PZ19WmRp4uHwhhg?=
 =?us-ascii?Q?rnwiOV4i3PGwWKYaZV6jejySMp8USJ5QwGZFx704xN144sMLVd5aEMSYkgOt?=
 =?us-ascii?Q?S64NyU/rxonrsYCgtEp705YO0YyBGFr1xnCe2QXQX3TkzAVhOOtg4gMypK05?=
 =?us-ascii?Q?bSAkkx5xbdmIwyhlI67Ut6+JrTbYHqmiLzAkPqkktWR51BQFZNd6LgEc6LqW?=
 =?us-ascii?Q?wY8hkRB4rdJcuje6dFgbTU5WPILhvP/U9kZINxKXYbGlKUicBZADe37HKJ92?=
 =?us-ascii?Q?FMoAqQ0rPlF4nPCJQz0Vt5h1MZcVdFdMWwDbbNliXLaa2EuB0dVSBUxafBp+?=
 =?us-ascii?Q?853jf6WfWAt+st7WK1c0vYdldP7iy46xaZ9HW8otXlfzgj5zmIIp4dsVJ04r?=
 =?us-ascii?Q?OBczWfnwgZ9tKAUstMdVYDiKE1TQyH7s8YIyWHAkCv28nD0BN6f0rkB4+9gy?=
 =?us-ascii?Q?TjBofHGUCnXV2BMgbavJ204ZqKhM8oIuUugqZXWxVzI4Lo+OT1ybkkPi6IEO?=
 =?us-ascii?Q?pGSyQp4ulvj8dsj4enDQLldzW8nSNgw7o9Fjm7mneycA3eaMtZDJg6sjVFPb?=
 =?us-ascii?Q?V1hDZiOw9P/L0Zv3URTTZHAxc1rwO1B2B5nKyk3mCrMcuCPoSzVZj/zrGvZf?=
 =?us-ascii?Q?HVuTG5JIUaa51b3eEsAiwl56a+B67njtcxDAzvS3UYuD9+CP6YMxOfEYGV70?=
 =?us-ascii?Q?v9gojzzkFgkLAV6hqMR/ZY7x2wLPbUEwoCYNsy+avZgBWzBBvt0rokTVWKa+?=
 =?us-ascii?Q?QB/OE6DY/VWJACVeoeLt4dafOzYf9ngEAHqnDR+JuX1a19e4Hfp19N/1Llv2?=
 =?us-ascii?Q?szuqc4vxaZlaxZClzIoayTG64kU6N6FB7lZrNe1ZiLcVnYvRHFnaE3jPLcdp?=
 =?us-ascii?Q?WkNvwCZ+c0YCnz/toZzE2+4Wq5e6gd9VjdXlzvtck7gBuco7CHHrKDFgdoFy?=
 =?us-ascii?Q?PdRT96On7auN29qSmfLhTfUxMfQ21P7bbuPJLjLu/hkdHAKt8pp5Shr3BhRc?=
 =?us-ascii?Q?uX2NAcEauwJgZQYOnfbQoYIAVJsTLwB/aJW7WjFPjhdFzzVwsm+R7kCc8zjR?=
 =?us-ascii?Q?KQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3EEC56E7ECF29F4DA619F7620D85854A@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: rXkksLLDNQtfR/+R+2nUEA+ST+31hiE9ibnTtrYTNj2PRfua85GjBUns3WkX6JfonBmx3al/l2tkzWcKelyAUVncuFa8Er5GS0/f+zQ53f7CgIUXw9oAHz0mKYoou8HaPoz8uPjfC+1gw2LLWPqwyAx1lZ7eADdnVa+hl1VPFji/FeeSHYIBRFtbRlTO8D0auVhIQEJJ92PLUdDRECwwSSt6eVeoobCZI7OECtRIc2nKZ4rMX124fa9hssaXEFOTFbtsxD74K7Qyb5UaI3G6vr8TuuP8wIYq65CBJG4ChCzobOB90ucPtDQM0JMxAcPisplUfZLIS2C8meo8tIBh63rn+emKhG6KbdYjozEwjbqGfulJnx5kT0ru7LDcsp7CGTRCzrb9eafSpdadrM+6L//HUCpylBTyo9sXvEhyvKC+wW7YwzYz6M3W58Kzv2eBVytwNX4sehqSnRPUb8sVh2KwYt1DAB7HRi3m+9dwV4t9OtwKAyL8oNu+cqtvRQfVNGsOndi0j6imM+xg4YtPn0QTmVYjGfMZFSQDGznw74DU3Vl715I/PRl22K8sg7TqsbcervxNe9KEJjm2cOmoylIwzRrWS7M0CmY27al5NhXRHvWmtyZk5HiU/TcLMHvXYXNWqZPl12EOWRcK0uOHIWjqLZJ+hZMc1vmGnsKfOQv4Ymx4sjuf3+7bPSic9TWyyPnQrb3UWZroDTlsnQ6n+nEDqAj09qLrxku90pzAJy/xTf3rkqhNqP13+tDTYMoHrGNnids1Fe2URs6fDNu9kZxQvvEExWq850O4kOyuDXDc+JhXkAw5tIYfTbHLOEDD4Ackl/mGHCuXNd8I7k+UE/u/hwt+izzAshEZvl0Ue+M=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f991a31-6c03-4f16-e6d4-08dbc1d17e0e
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2023 16:22:50.9871
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w5rxVV0Wwi6Mvkz5Wnr7eyFLTBueMHNgx8uImVYPSS6Du88Zai6BJRfB3wBdIqrz6j/EsUUnj/OQvx5d2A/Z8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4479
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-30_14,2023-09-28_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 bulkscore=0
 adultscore=0 mlxlogscore=763 phishscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309300135
X-Proofpoint-GUID: v9wVOrOahe9UojxcIWE3x-yOzw0GUaeU
X-Proofpoint-ORIG-GUID: v9wVOrOahe9UojxcIWE3x-yOzw0GUaeU
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The following changes since commit 88956eabfdea7d01d550535af120d4ef265b1d02=
:

  NFSD: fix possible oops when nfsd/pool_stats is closed. (2023-09-12 09:39=
:35 -0400)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6=
.6-2

for you to fetch changes up to 0d32a6bbb8e7bf503855f2990f1ccce0922db87b:

  NFSD: Fix zero NFSv4 READ results when RQ_SPLICE_OK is not set (2023-09-2=
8 10:34:28 -0400)

----------------------------------------------------------------
nfsd-6.6 fixes:
- Fix NFSv4 READ corner case

----------------------------------------------------------------
Chuck Lever (1):
      NFSD: Fix zero NFSv4 READ results when RQ_SPLICE_OK is not set

 fs/nfsd/nfs4xdr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--
Chuck Lever



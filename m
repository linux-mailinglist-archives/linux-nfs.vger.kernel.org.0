Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7B9D78B6F4
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Aug 2023 20:03:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231322AbjH1SCu (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 28 Aug 2023 14:02:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233071AbjH1SCn (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 28 Aug 2023 14:02:43 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43EFDF9
        for <linux-nfs@vger.kernel.org>; Mon, 28 Aug 2023 11:02:40 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37SHxDId005467;
        Mon, 28 Aug 2023 18:02:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : content-id :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=Vt2T/SwMXnd/tXv/07NH9MnQY81s9xwO4zKIgFBr1HY=;
 b=1CrYV+eyl6UKeRHpuneXCbHZx5R/P4UbhJCZNHvBQx0Z03gs3eFGyBa9pI2s0A4VTyN0
 Gv9X7IIfWbk6Ld8Jvo3F2ssdpHgJmy2MsJcQuCDTlwgdWQ4nt9LnK7RkN4FEXdzVlcl9
 qgc69SAxHhss7GnxXAkjuZKYJjObl7p7+T5gpJXR/JB30e0AaOgH4Xz+EkeC1rvTFtn8
 jIodKhwgEfLeasf7JIG1iTgxfFregpOhLoHE/EbMCn3S1w3p7z2E1V4CZdO6uWdXeCom
 WdhhpuWDwryc0hwRR/1VIr86l9g0Yqmat50E2sw8oxRBD/wG43todCF0Q/QQGGgr73H8 2g== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sq9j4b9y7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Aug 2023 18:02:35 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37SGSbcD020654;
        Mon, 28 Aug 2023 18:02:34 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2103.outbound.protection.outlook.com [104.47.70.103])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3sr6dm1fec-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Aug 2023 18:02:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gUCoWFJMMXbB+W16F1Uivnui5tXewddTo41LRItGXXRVj5jzOx7djdHeekAUVxu+lp1tVm+xTQCNNVif302Met6NxV3D+X1IFCdxB/rkQFZ8oFqA7e33fVd0aQ0koIM9Vw++eiQd1PiO9IwgtfW3VDxiStukp8EcTuS0o5Y0k0CJ2vR8R8FVN7/XNxgQ3C/VDQPwlV1gQSWCGTyJ/Y9cy0HNJZ790WG27LmwnabyZMw4Q7i/1ZQYWaBqMafkn6V0rtOeHyZcz8Dhc2OWuMGiGR+pfHmHZM66g8TwUZA5SMdQKVpDTZWWM5U1VC09VDCp9+3wxlBUtb8vo2r0Wy9gvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vt2T/SwMXnd/tXv/07NH9MnQY81s9xwO4zKIgFBr1HY=;
 b=TNsYJMjkOmaVbQ7sZcLNSBxBsZmvDQXi18gnTF+VQ1uak0aTuL570U4Tx/C+jiyi6AkgS9r0fXbjEhFMjdghlw7Oj/YwtkD6CKsnUMDHXFLqdRHbgw0dufTMjn4XGrqHiW6B88PrZz6+4UHk1Y44TIZ+nN0jqu7h/lGBPlObBq11kWzBMSwBHf+4A55xOeqAtfMUfyG467hHHA8W9glZjH9k5jkWydCjSZlBuWlsU3DtHI63+LAmRu6kUJ2vHwzJvWGd2l6CEVJbgFFTovpr/k9UpTDVPej7CpG4ozRheHCj/+gvzVbyjNrIiaiQaORyYKPNE83J4MXbDXDZwjcHVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vt2T/SwMXnd/tXv/07NH9MnQY81s9xwO4zKIgFBr1HY=;
 b=AgQ3nRidhuiTqlYLGP0fZ5iwm0Z27GCgu9Vki0pWJGMbOxFkWjFfMmHR2o/ZcmBHGfQLQtZN6Jbs71xH6eTImvbEFPPSXBxTpD1UYOpAkJcPOYrjqUe2aj9D5zXMA2iWLKGe5X0wkQCZxfv7VVPgAEj0snexTCwDKEFp42stGaE=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS0PR10MB7173.namprd10.prod.outlook.com (2603:10b6:8:dc::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Mon, 28 Aug
 2023 18:02:32 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e%6]) with mapi id 15.20.6699.034; Mon, 28 Aug 2023
 18:02:32 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
CC:     Anna Schumaker <anna@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: race between handshake and socket close
Thread-Topic: race between handshake and socket close
Thread-Index: AQHZ2dnR3Sj9MZMTRk2NlPmocHRLow==
Date:   Mon, 28 Aug 2023 18:02:32 +0000
Message-ID: <7B346EC6-E1AE-4C8A-A205-92068D5104D4@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.700.6)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|DS0PR10MB7173:EE_
x-ms-office365-filtering-correlation-id: d849e89d-e8bd-47d4-e2f5-08dba7f0f394
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GnLM71gFFl+BWtMurq66rQVFGJMWRy4z3XOxSV/C/yku+dNOlOoJZ9kp3YdOP9n3JuLVvLIlwjVajMj/u8fV0EvUDJbBrQFwCqWhEO4qLsKxwTeMarwehHmHxyNIv3Y2nbwgXCU0zb5WLqtdpb1rnUBkfiSQGxrBTDiZ4XaHzYT2UT/Zhrn/py7pTnIWTYXGLXUpQrFID6OmCEPXhG3TjYXzdirJ1hNVO1/VchSE6DaCPuXCcJ9FyLve6odExRS/hsMpUdneuf6p4K49pPlhLq0DBUPTB4dJN5N/uFf7ZrzAney4IVjMgs9Ry0JFjbT9uSOBz1/s8KhkBtIWls76gHxtveKk2ilSbzvubt0METJPMUXfIyfNrlYrUMx2HAefiJQZd32NOefa6y0QtL1MsEz9atR1GLIx5z7WjBmVFPK4OOsjHtczP1X0IKnNXntZdfc0noKHVlx8M+Y+e0UHFFK60rUo6x/p1hwdfqFhluvD1tsz+lb0jmLIGCGFdtyEajawC5q/Th4rofN2Ohi2aibi2S35U62Q9/DQEuc/aKpSLmPWLlkhW/ltCWvSHrT8MHx2ZC0yDo2XHZcGD2LugCEPwzKSc6nhO4aHvshUIuk8paHkWBw3wvD/w3Wk1IPD44ZitBoFMvnKaulFomzelA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(366004)(346002)(376002)(39860400002)(451199024)(186009)(1800799009)(71200400001)(6506007)(6486002)(5660300002)(36756003)(33656002)(86362001)(38100700002)(38070700005)(122000001)(40140700001)(2616005)(2906002)(478600001)(83380400001)(26005)(66556008)(66946007)(8676002)(76116006)(8936002)(66476007)(54906003)(6512007)(41300700001)(6916009)(66446008)(316002)(91956017)(64756008)(4326008)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Lp//2YNRW+alBngN9N18h3xLH/MUjLBKYY60LNgxsjwaVN84S/Afi7qCeCnr?=
 =?us-ascii?Q?QRJtuSGhE6h6vM4bsYp1TPy7hYNUD4yMiQFminQo0KQdUi9ebHnZ5YAgrIVn?=
 =?us-ascii?Q?0SJrfsi418ozLN0tl2tnbxASnqxSMRjbjiGtD7IIfuOue4m/JhV7BxdsXrpF?=
 =?us-ascii?Q?APPkrEOn/obmox+LC1xcHRsBjF42lel73ivr0AP3TQNOy82NUx8dN2u3yO90?=
 =?us-ascii?Q?yMzjxZY57ZbecKD2KC8TWIDY10bFJBSx8WL2YPZFI3sjG0T+qp0GUUk/hNil?=
 =?us-ascii?Q?KYEuyRDJfKgr78RyT8UgX8Sue8mP+h50oN4SIIM4x1+Y0Xo6lk+K6Eh64Fvb?=
 =?us-ascii?Q?lNkH/LnPIEkkhQ7vTpvE/mdYvo0cwPcNnTAWzlVl4CHcNgz3KokeMP1KEtRU?=
 =?us-ascii?Q?B8ciqB5mmOHN3XTCYW66p330qS8GOLjWZiQMh0Ll1IeB91T1n80Bu7PBpsNK?=
 =?us-ascii?Q?1TfpVBldlagsNL8r4t7ia3RaqaHBrz/Yqi/UmNh2hi1iUjCpNCo3F6fxYeK9?=
 =?us-ascii?Q?XfuiG8Kl7mHEC/pHoo6SuuD7kxgL+sEr/6NPwJIJIs6oyJUkR2gMvtXQ/da9?=
 =?us-ascii?Q?44LuZempJI7qap2ibKanlRKvYT5jK2VB7Ch/cUyvonXqBYwGpWg773Lurmb3?=
 =?us-ascii?Q?2yZFLvJyY3uwFs4Ac0dRSJ34McTwavrXLZO1xQDRUz5Ml2+9nOOy9Z1zGzH0?=
 =?us-ascii?Q?axA9SBwp8/2fgKH9pL9ZfTyCsof86obYsBgS4l7tCRgfGYSm1t/f/bVf5sD3?=
 =?us-ascii?Q?Ulms0J/996TQEsOh3li7gqiflmvYKrroT8Y1xXOHBkfsonUWn2p0bjZHwYFr?=
 =?us-ascii?Q?ReNeAQPJknuiWOcqPj5MhBFmKPVGBMigxuQaUFOxmxEn2wRgxrw8g8VDexdz?=
 =?us-ascii?Q?4KwtnpgdktPGnQPg+zGodGUEzWW90A8bPmktlpOPkdzxq9l7jO3uhEknxIGf?=
 =?us-ascii?Q?YdILpwTgCBjRL0yhzAlV4Z0Cz57/5uRIsQme+/wzza4Eq6cjGDeG4vaecww6?=
 =?us-ascii?Q?N0lTO+2zE6SvslroI70veMx7W3h1vgXRo/yxKrH4vNqNCTPpeKd74lH6nT23?=
 =?us-ascii?Q?PW0hWhtKX8hqNnqoRqvRFdBV5shsdjyu/kA5slWo8+xaycrYQ2KBxqDzGr9K?=
 =?us-ascii?Q?Qaktqwd7q3FofyxbckHkM1mZlL6rvczYcnti0tkHCYaSJZ5/WMfKQxDeBNdp?=
 =?us-ascii?Q?BNnjJw5hR0efV7LZVelBe71zAvNOKKYXL7I2GMydM1gHJs09v4H1dxq3Iysq?=
 =?us-ascii?Q?AH2ZEzEijotzVVZ7UpBXsgWMtwjReMBGhNtGS9dBEVozYW4unERYaIvi6ua7?=
 =?us-ascii?Q?Ej1gWOrOeVdSr9lUI/o2flpnZNTLvXBtSaTFWiS23cIR/9ZT0Qux+ojM9/Dk?=
 =?us-ascii?Q?Yo823nHD0jq3B/kS+FJ0jP9KTptGpAduaWjE7wbDXxSDAYimorGz9p+swtQd?=
 =?us-ascii?Q?56xF0q9G3jthprIVZizY6ttheILHXSqk1MpY9kRwYaENeWJkiHB+MlMhyxgN?=
 =?us-ascii?Q?X7YHj4gH3LSNiv/3VmPy1AUVxLRbOECb9jMGWzTp1E9srnBgfyAOIdQ248J9?=
 =?us-ascii?Q?nlcDVlYhlPnPVdydTdFs1VCNFMY3ACrbKy6DAO/erOIP6pXIEIkjWG85yUYZ?=
 =?us-ascii?Q?Sg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <AE642323D9714A4298E3521D93401E24@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: D92x3XdKSoqzmRvN4QBMesmj6XAOUuhaWcqIsMTvK3Dl0mVcibRn7frcxcS0l1S+RxxcOAtsjpanvVT25d+GdbL0gDyNVOKPiCA6lcZqGScOKh/krpABXDMP9jmMpOXupp/wrHYGsbIAencWcHKATCHL+IHk8ReQmYUptyjIehXouuuwIzFxLa2YGtadmhBgLfKywyFj8M0N1B17+jSd4lMeMNShjWjll+X6SKV6HTcT7wb4tQ9MtQg6SBXA7QieoRZbqsXxplJGmwMUNYVGjp+60SAWnVoVMtL6/O10YG4Fnv4vy//j8yNa6mpW3/Agx/y2V0gK9nIm6rUxEjryBhyrzOdaDdtYlJulVKhi2o/A/fGSV1kQQBffrfkyrWkNOsGPQM8xnJjOF4ZwRJK3Y28vXVrvPyMXP32Q/tSOfrL1X3/Xx2nxQgmlBnWqMsDAc/zfSbHewvfrjqhwGaLIJMchVnNTg1HptAXlVzIUp6844vH6mP/4j+BDKsHkXo99BeB1q3pQVxoxIQyJHxOdsrB1y9LosTqc08Cu6kCTVSOj0H/ASopwPKYnfof12QKVtH7zeOK95Eb1eYtLXWonIJKlCsLK6uKKXMO6Ca/4SU4rveGR68hZdBNjng+jzCwISw+yXduMli8lHfdwZlT9QNtw0S+7GgYBeYtZ0CSY4BgZXBtyFzJiqMO/GNdaY6fZJlTrN1i85s81C07zZmGP54y9F46yIUByV2JMb34kFGj+OcEvwatLWDkCWPWoe9YfH2lUWB9sXdk9OD9cazV1QqLtfHQy1im4cn/c86V9bgCBbvjgWpjpP+swoutZ3zQYKU0CTOnIP74VtErJAHTyzA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d849e89d-e8bd-47d4-e2f5-08dba7f0f394
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2023 18:02:32.3306
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oo//D+xWlp+cuiu4rFWzqz8beHmBR8Wj8N1N6NaN1C/5LJnrYb0XXkD6dlui5uZrO4VsLNU+EWG9jZpSdOf1Ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7173
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-28_15,2023-08-28_04,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 adultscore=0
 suspectscore=0 mlxlogscore=933 bulkscore=0 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2308280159
X-Proofpoint-GUID: b9oBtVINrgPq36ue7q-6FjhFFhkGUv2m
X-Proofpoint-ORIG-GUID: b9oBtVINrgPq36ue7q-6FjhFFhkGUv2m
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi -

Anna has identified a window during a handshake where a socket
close will trigger a crash. This could be a common scenario for
a rejected handshake.

          <idle>-0     [003]  5405.466661: rpc_socket_state_change: socket:=
[59266] srcaddr=3D192.168.122.166:833 dstaddr=3D192.168.122.100:2049 state=
=3D2 (CONNECTING) sk_state=3D8 (CLOSE_WAIT)
          <idle>-0     [003]  5405.466665: xs_data_ready:        peer=3D[19=
2.168.122.100]:2049
          <idle>-0     [003]  5405.466668: rpc_socket_state_change: socket:=
[59266] srcaddr=3D192.168.122.166:833 dstaddr=3D192.168.122.100:2049 state=
=3D2 (CONNECTING) sk_state=3D7 (CLOSE)
          <idle>-0     [003]  5405.466669: rpc_socket_error:     error=3D-3=
2 socket:[59266] srcaddr=3D192.168.122.166:833 dstaddr=3D192.168.122.100:20=
49 state=3D2 (CONNECTING) sk_state=3D7 (CLOSE)
    kworker/u8:2-2367  [001]  5405.466786: xprt_disconnect_force: peer=3D[1=
92.168.122.100]:2049 state=3DBOUND
           tlshd-6005  [002]  5405.466786: handshake_cmd_done:   req=3D0xff=
ff9e8a43c7d000 sk=3D0xffff9e8a42e2f1c0 fd=3D6
           tlshd-6005  [002]  5405.466786: handshake_complete:   req=3D0xff=
ff9e8a43c7d000 sk=3D0xffff9e8a42e2f1c0 status=3D13
    kworker/u8:2-2367  [001]  5405.466789: xprt_disconnect_auto: peer=3D[19=
2.168.122.100]:2049 state=3DLOCKED|CLOSE_WAIT|BOUND
    kworker/u8:2-2367  [001]  5405.466790: function:             xs_reset_t=
ransport
    kworker/u8:2-2367  [001]  5405.466794: kernel_stack:         <stack tra=
ce >
=3D> ftrace_trampoline (ffffffffc0c3409b)
=3D> xs_reset_transport (ffffffffc0814225)
=3D> xs_tcp_shutdown (ffffffffc0816b3e)
=3D> xprt_autoclose (ffffffffc0811799)
=3D> process_one_work (ffffffffa6ae2777)
=3D> worker_thread (ffffffffa6ae2d67)
=3D> kthread (ffffffffa6ae93e7)
=3D> ret_from_fork (ffffffffa6a424f7)
=3D> ret_from_fork_asm (ffffffffa6a03aeb)
    kworker/u8:2-2367  [001]  5405.466795: handshake_cancel_busy: req=3D0xf=
fff9e8a43c7d000 sk=3D0xffff9e8a42e2f1c0
    kworker/u8:2-2367  [001]  5405.466795: rpc_socket_state_change: socket:=
[59266] srcaddr=3D192.168.122.166:833 dstaddr=3D192.168.122.100:2049 state=
=3D4 (DISCONNECTING) sk_state=3D7 (CLOSE)
    kworker/u8:2-2367  [001]  5405.466797: rpc_socket_close:     socket:[59=
266] srcaddr=3D192.168.122.166:833 dstaddr=3D192.168.122.100:2049 state=3D4=
 (DISCONNECTING) sk_state=3D7 (CLOSE)
    kworker/u8:2-2367  [001]  5405.466797: xprt_disconnect_done: peer=3D[19=
2.168.122.100]:2049 state=3DLOCKED|BOUND
    kworker/u8:2-2367  [001]  5405.466798: xprt_release_xprt:    task:fffff=
fff@ffffffff snd_task:ffffffff
    kworker/u8:7-2407  [000]  5405.466804: bprint:               xs_tcp_tls=
_finish_connecting: xs_tcp_tls_finish_connecting(handshake status=3D0): soc=
k is NULL!!

Do you have any suggestions about how to safely prevent ->close
from firing on the lower transport during a TLS handshake?


--
Chuck Lever



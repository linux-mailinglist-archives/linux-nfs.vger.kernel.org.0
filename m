Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAF4078B8AB
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Aug 2023 21:47:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233496AbjH1Tqn (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 28 Aug 2023 15:46:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233538AbjH1TqT (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 28 Aug 2023 15:46:19 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9814718D
        for <linux-nfs@vger.kernel.org>; Mon, 28 Aug 2023 12:46:16 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37SHxFnN001078;
        Mon, 28 Aug 2023 19:46:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=guikIK52xV7Eu2TDvMm4bcmtbu6ByO0OyNU54DNV5U0=;
 b=spvc2ee9LSN1ZlaX0HgR4qG/f8WGOoJ1mbO/DG99myM3LJzJybEXW+n5pg5dJjmOCjiK
 qTNX2Y9nVwAlq8A9weLq3I1GKcPlLGUWPY19VxSC8fJgxw4pQieAzKp3DX8qbwJxOpMu
 mmscMzdEnQWY/5TKi4wZ6rrG+tgzEzeHonjbS0No4qQqKTBn4NWOZ8WJEG7cbtlnP+to
 ARospjaWfV7pGHi8zILB54mPbSbnjFpaWF+ozlHOMCHDtlALLLENXcvsjXs1MKEqaExl
 5/Srojw8LgIEDPQBbTxDAP5OBqSpBskwJDHNeWxz/R5nqnol2uq9VUZX9VVZYlM2y1FZ cw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sq9mckfkf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Aug 2023 19:46:10 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37SI0aTn036829;
        Mon, 28 Aug 2023 19:46:08 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3sr6mm5f15-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Aug 2023 19:46:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A7k0/zcdW7CeC45iriPJVwD3M4yztw5Tl9Ay9Vnm5QPZDgXUsm7JUVYWfyydXi8gKL6/As/UCNPjncZEUtY3I2ibH4mG948crMubgiBrv+znfSxm3nnFz3y94TeZrGmqjcz53U0WjoS7ZjjtMPWxLZPZwLddEP/wfazYpSuHjeJj+3SDTNuRM9uefxakLfTsseTxVkD+oNi/4+ISpUbh3IJrGZaNOPapYZNy1tDx9zGbo6iLsRc0jrIedjFTrnmpvQ6xSCbBZn62+in1oCruOsOw3xWaNq4rfRnlUuWokWZCtDs6rWGfAIVM448QtK8+6aBDGfXh3+SSuqSm/Cda8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=guikIK52xV7Eu2TDvMm4bcmtbu6ByO0OyNU54DNV5U0=;
 b=CCqRIf20mH6//Lkpb0DLMn5xyM7J+Kqv5fGOGaM8w6jteYBILXr35y9yvZA+xMtiorehRA4Ds0MKrPAKLMU+ai+iet2JPlmjxB49fd4lKvpe693FCK7UAkTPPmRMJ7lhRBpCAl8pxTB6y5cTbjIFa6N8a3Jm/Fc+kCEttIUvmqo6n8PYE9qigIwDHb4lYJwPcvoo3t+DZm6r50yOwh++nC2d//OzE3ejS/ATpIM0r+qRlk1HmC9gz0R4aWC/i4JncPbsu26pZ8a2BQH9UGXnRNNrB772h4FWymq0eR4c38zVLqkGJHKkF9jY1czfyZDKTIfil4ouS720zvIYUt8yeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=guikIK52xV7Eu2TDvMm4bcmtbu6ByO0OyNU54DNV5U0=;
 b=H1hEtlZD3uvAPCytW5VrXueG0SMBggkWSeq3XTSVhFiNVE+lUgooF2oTeNU65kKB2bIiGa2AvFyf4Q2clhUAPm+EJvwFfq9g7gk2q7Varcsbz/ah77uuu0GPHy+4MJfZ4uTkO/KZ1Rshx5W8Ml7k1XA7VvJKDuiwjGNK3XPZqLs=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CY8PR10MB7315.namprd10.prod.outlook.com (2603:10b6:930:7e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Mon, 28 Aug
 2023 19:46:06 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e%6]) with mapi id 15.20.6699.034; Mon, 28 Aug 2023
 19:46:06 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
CC:     "anna@kernel.org" <anna@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: race between handshake and socket close
Thread-Topic: race between handshake and socket close
Thread-Index: AQHZ2dnRD5G/pH6q2Eyc36/UYMliYrAACT+AgAATkAA=
Date:   Mon, 28 Aug 2023 19:46:06 +0000
Message-ID: <EE62D216-464A-4904-8F34-5203C1A1A48E@oracle.com>
References: <7B346EC6-E1AE-4C8A-A205-92068D5104D4@oracle.com>
 <1efbc83394dcc890b83526224e9077430e53604b.camel@hammerspace.com>
In-Reply-To: <1efbc83394dcc890b83526224e9077430e53604b.camel@hammerspace.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.700.6)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CY8PR10MB7315:EE_
x-ms-office365-filtering-correlation-id: fcdc53c0-df7c-431c-568c-08dba7ff6b53
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rrdSF9pptYymyGuqQlSLa1YwLlMF7v0c4zN4Jkc0X9YkjW7q+KYUKZkeSPf4FDSylfrY+lAlbya+hV258KZbl94ljI18P63Zu6wQd5WF//Q2uR8kOC7OpbAZEwZKt8vLk3lGuOYMIYC3kemk5EM4z0fAyact+f309FeV6VOI5TzXfzYzSmenuolUk+jsYRKno5TKiCk8pm6h8acEOw6xhdOB9V3prSaxEKTVnHlj7Z+alIVGphvFVbPKaFUh0kMcSh3ZvyRX5FkYADO03pjwzzoafVozLgj88tkpXWa2pGBniLfJyRq6s+H3QEq/14qeR0KqyPmB5R2nuBz+VAejRQ2occEAn7vJv+8cFM3v0SZhXPhzQ13rC1k1vUaruyrxC7KUvuTXAPLVTnwJ++LNKZqGOZhdEJE3PlTaewbZCR272C0xiknGzGgD8p5j43FBElsZ96PYr+Xu+9JJbeuD+OKjApbsdPJhySS5xwahqG4B9Hb9nWyKRg2Bag/8kQcmHYcO72o4DBzI7feYQaRZwJPN3buFbz32p6CuFil7yl3dD+R+KsnrCS1a8UL8wMlHIkweQTaChZ4Appjnob6snTu/vep+8btCnBBxEmxYjHKQ3LE1RfcZrtYo0u20x5sEJbCrn8MUONyoCHMu56driA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(376002)(39860400002)(396003)(366004)(451199024)(186009)(1800799009)(122000001)(6506007)(6486002)(71200400001)(6512007)(40140700001)(36756003)(33656002)(86362001)(38100700002)(38070700005)(478600001)(2906002)(26005)(53546011)(83380400001)(76116006)(91956017)(64756008)(66556008)(66476007)(66946007)(41300700001)(4326008)(8676002)(8936002)(5660300002)(2616005)(66446008)(316002)(6916009)(54906003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?pEf4MIMJKneVeuFhEQC0waO57EBgib/lsNwvcCaNWeesNkgJhz0cQ5E0QeSN?=
 =?us-ascii?Q?+f70cCybeZ8D5dBsd9X54DNwDXfoK0gCGhxVUAFEyt79+Mrf9RI9U2j48yjx?=
 =?us-ascii?Q?w/C8eF61vUIki2WsoqA+eL+6ag1mEVHw9LRJwXYtMuso8BaKN5EDHqGK02FO?=
 =?us-ascii?Q?lfEHGyDAbmuSi6rnfi1zVYzIUiBSws0clNSu73Zf6Av6/ildA8cVS3ScsxZx?=
 =?us-ascii?Q?GdcrEoO/3jC2PiUBKxkEkTtslp/Kb9Vuv/mHZ+JKAqHvizSXdUt0J9y5nzJj?=
 =?us-ascii?Q?Jl+KTB39ERVnjVaVp7HLi8V2Jz+R2OsvXnrqUzP1Jcj+V+dds+pQ8OPsPf4W?=
 =?us-ascii?Q?fkYfOsUPhJQjzDKwly2I/158I33IsXCXQpe7BHOHN31nXwFSTOuoGccgYxAH?=
 =?us-ascii?Q?DCUPVWZ8+jgE4YwVThVIw+agbf3En2V5GqW2wlpXxNYcw7D7HJs04ZcbSeXt?=
 =?us-ascii?Q?hExs784U7rp9GnYOD/HobSklPWH7iSEJn/UmlA1d8lV85MG+IdL9gN74h/wg?=
 =?us-ascii?Q?mubjjnDBlUxdHGNYM6zLmPECtcltMDqlkp3jeeg/k285JVOg7l07lllYR23A?=
 =?us-ascii?Q?b9xbBlkOezs9+b1lcyi1appX+4y2M4cgAHizqoq2aySQTuqt4nLS6rzg8sZZ?=
 =?us-ascii?Q?5dI6wpspRIa1TCiZ/YsVaWlsJ8ZCbK56ESRpQhqRWv62G0wPS9BbT4XLR7hA?=
 =?us-ascii?Q?6/rJVpwCr9lZuU6+5nV6ew7iPmR7Lep/JJuGFbJBsN/n51umWskwsohR/Ui8?=
 =?us-ascii?Q?gFW6QyonDUnBLVh6NJhQGJM66j5DiDsQrvJGuoZ7Zs1yuBMhkbxwcKB+L04m?=
 =?us-ascii?Q?X0YqoBDDmXpuZu102uSNcMbLMnRK1MNIZsnBJgLqGubbrInBm3w9RREpWyuw?=
 =?us-ascii?Q?LFVvVzox2ivuvFCkQFQ+nP8paaGDfSzBoogB3vz2FbUFn/2goQe/urPdzJIp?=
 =?us-ascii?Q?USKSoPm2zx2pki9fAx9IEpZ1bzxh1PzhEPjW8fDtlbJYsQ/ciokVaXQW2Uhh?=
 =?us-ascii?Q?DUQXxYR5lmm6WTA0PJKlGX4Nd6l9xI1rG2J++0EBpulFKVhVaYFz/PbBzs1Z?=
 =?us-ascii?Q?YRKca6xmWrgErkAo0FmrqLetIXvBqeYjHvu+sSBmFaY0eup8hwEcKXY1J/E0?=
 =?us-ascii?Q?iGp2boli3DX4oR+Ul0gscRrYzfeNLR9qu7F+caMR+KEVHMCab6uksC6S52C5?=
 =?us-ascii?Q?mCIu7zkOI2QKoTWa6FwjAVOMJtIVyZ2UlMkc0K21jkBv+WDwbJCCtyfTdfq8?=
 =?us-ascii?Q?KptLRCiSiAEGtOkg9k4v45Nfrv0bPRuLhH44IMYgInEBW9QtXTIjKJGCjFcE?=
 =?us-ascii?Q?AkgpkRPaZ7a7rkvIAkoA55otuYuU2rFZp3UGCd+u0ZSDpAw6xNLA+OqSEfEV?=
 =?us-ascii?Q?aQ5XonR9bAiGWGE0TE394PDz6rXemzX74KFmbxm1ktxDBAlcBqK8DupWTquA?=
 =?us-ascii?Q?ctgPtsM9KIUWeYR8TxhxkJwQILyDTRE713JdCr4umBiCaZZILcf7JQqn/NKI?=
 =?us-ascii?Q?/3lOwm+qiNFdfMRKWMsRgPkaJf/eUUrD0VcDyztKMM8UqdMJx4SY0U2dSRHY?=
 =?us-ascii?Q?c4eDbhp3B3N/S27J//ujU1ekluRjtaJux/vdjGdjDNyEYhmCgWRRCbagwKLe?=
 =?us-ascii?Q?tA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D65B7D26C9F3084DAD1AC215DEFE706F@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: IqBNXjplg6klILLs71kOvRZuDzPqhlyMoIWflud6PuyEC7HrheMJmJ9hn0eAyGEwXlk+ZtsZ3lWeNW+FhoBlkzS4tl8Au4IfOHeUFuGS9OiXyRnwHy27rLg3RBpEoMvbcrYahuygbQzTYN4ou78psXxoNiqHkRzEyzQ+VAgirykZFRgahMAAHWSMjtX64VIN11heYoA7kHnWUFOJDJ9k0R28q9DS2bG+P98/TYtb5kG0gKBevbhbgIF/LYLAFJe3pEN1O4x3LPtVgfEs6TKxiPe1FPSqzhNXNxxOM0g3jmxO6DpK3g6uNaqNS/vsSH/M2xPUYt+fTsU7jFPLlkSao1ndczCwVhwtTEW3OarKP4ECvNyJhe8OnDt8ZOHsB242hjJOBfUMsrgPbVllxro9D8/ICfazC2t35QINokaBxdOgg2t7c/tTZr4HlfgEzryJQxSPdFIjphBuWXUgwk3bFM+9E1SVO70xkRXLrlr9UTZgbdXAMiskgzbHUMOz29B17waq7pgnfAHoeyiCBM1dbEX+ArFIzThPTaPD4utGIxrb8AiJHDkXXTWYtkpP7WFuMCixEWBXPieS3ZlYQyfZT0aKdr5zAkT32SQ5QbqSJlhheWV6n8cNhnUl/kGlRYlqtlecZqh8jzH9/ctAZ2hYEadMVhk817tLA1Y09mteR/BiA/TXSUYc9VODtXYYBLqXVetT0PEQKnVbtMN/44gaQ40FjPx/kx1jfe8XbMpOsE/ewE7t0KNMZT8Mgwg6UZVKm9XCJM5koYnv3swKfJpewNfNBXdoewgLuy5Rty//RQeahln/B5O9PzSVoAOgT3rUnp5jJmkSxYFgvILgH69D4w==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcdc53c0-df7c-431c-568c-08dba7ff6b53
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2023 19:46:06.2041
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UuV52ACYIPDiCNoyNC7bkxkur+H+MymsABqeitnvayaTmskEoqJdC0UMi+YVIP8Gb0KVXN/p0IordtmaMVDJwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7315
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-28_17,2023-08-28_04,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 suspectscore=0 spamscore=0 bulkscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308280172
X-Proofpoint-ORIG-GUID: 7hMd57eU1KF1xFeE9juSQjPlrGhR9qJZ
X-Proofpoint-GUID: 7hMd57eU1KF1xFeE9juSQjPlrGhR9qJZ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Aug 28, 2023, at 2:35 PM, Trond Myklebust <trondmy@hammerspace.com> wr=
ote:
>=20
> On Mon, 2023-08-28 at 18:02 +0000, Chuck Lever III wrote:
>> Hi -
>>=20
>> Anna has identified a window during a handshake where a socket
>> close will trigger a crash. This could be a common scenario for
>> a rejected handshake.
>>=20
>>           <idle>-0     [003]  5405.466661: rpc_socket_state_change:
>> socket:[59266] srcaddr=3D192.168.122.166:833
>> dstaddr=3D192.168.122.100:2049 state=3D2 (CONNECTING) sk_state=3D8
>> (CLOSE_WAIT)
>>           <idle>-0     [003]  5405.466665: xs_data_ready:      =20
>> peer=3D[192.168.122.100]:2049
>>           <idle>-0     [003]  5405.466668: rpc_socket_state_change:
>> socket:[59266] srcaddr=3D192.168.122.166:833
>> dstaddr=3D192.168.122.100:2049 state=3D2 (CONNECTING) sk_state=3D7 (CLOS=
E)
>>           <idle>-0     [003]  5405.466669: rpc_socket_error:   =20
>> error=3D-32 socket:[59266] srcaddr=3D192.168.122.166:833
>> dstaddr=3D192.168.122.100:2049 state=3D2 (CONNECTING) sk_state=3D7 (CLOS=
E)
>>     kworker/u8:2-2367  [001]  5405.466786: xprt_disconnect_force:
>> peer=3D[192.168.122.100]:2049 state=3DBOUND
>>            tlshd-6005  [002]  5405.466786: handshake_cmd_done: =20
>> req=3D0xffff9e8a43c7d000 sk=3D0xffff9e8a42e2f1c0 fd=3D6
>>            tlshd-6005  [002]  5405.466786: handshake_complete: =20
>> req=3D0xffff9e8a43c7d000 sk=3D0xffff9e8a42e2f1c0 status=3D13
>>     kworker/u8:2-2367  [001]  5405.466789: xprt_disconnect_auto:
>> peer=3D[192.168.122.100]:2049 state=3DLOCKED|CLOSE_WAIT|BOUND
>>     kworker/u8:2-2367  [001]  5405.466790: function:           =20
>> xs_reset_transport
>>     kworker/u8:2-2367  [001]  5405.466794: kernel_stack:       =20
>> <stack trace >
>> =3D> ftrace_trampoline (ffffffffc0c3409b)
>> =3D> xs_reset_transport (ffffffffc0814225)
>> =3D> xs_tcp_shutdown (ffffffffc0816b3e)
>> =3D> xprt_autoclose (ffffffffc0811799)
>> =3D> process_one_work (ffffffffa6ae2777)
>> =3D> worker_thread (ffffffffa6ae2d67)
>> =3D> kthread (ffffffffa6ae93e7)
>> =3D> ret_from_fork (ffffffffa6a424f7)
>> =3D> ret_from_fork_asm (ffffffffa6a03aeb)
>>     kworker/u8:2-2367  [001]  5405.466795: handshake_cancel_busy:
>> req=3D0xffff9e8a43c7d000 sk=3D0xffff9e8a42e2f1c0
>>     kworker/u8:2-2367  [001]  5405.466795: rpc_socket_state_change:
>> socket:[59266] srcaddr=3D192.168.122.166:833
>> dstaddr=3D192.168.122.100:2049 state=3D4 (DISCONNECTING) sk_state=3D7
>> (CLOSE)
>>     kworker/u8:2-2367  [001]  5405.466797: rpc_socket_close:   =20
>> socket:[59266] srcaddr=3D192.168.122.166:833
>> dstaddr=3D192.168.122.100:2049 state=3D4 (DISCONNECTING) sk_state=3D7
>> (CLOSE)
>>     kworker/u8:2-2367  [001]  5405.466797: xprt_disconnect_done:
>> peer=3D[192.168.122.100]:2049 state=3DLOCKED|BOUND
>>     kworker/u8:2-2367  [001]  5405.466798: xprt_release_xprt:  =20
>> task:ffffffff@ffffffff snd_task:ffffffff
>>     kworker/u8:7-2407  [000]  5405.466804: bprint:             =20
>> xs_tcp_tls_finish_connecting: xs_tcp_tls_finish_connecting(handshake
>> status=3D0): sock is NULL!!
>>=20
>> Do you have any suggestions about how to safely prevent ->close
>> from firing on the lower transport during a TLS handshake?
>>=20
>=20
> Shouldn't something be holding a reference to the upper transport
> across that call to setup the lower transport connection?

I didn't see other transports holding an extra reference. But it
can be added.

However, I don't understand how that would prevent the socket
from being closed and released while the lower transport still
owns it, which is what is happening here.


--
Chuck Lever



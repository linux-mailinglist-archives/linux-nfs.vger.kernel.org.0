Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B865D5364BD
	for <lists+linux-nfs@lfdr.de>; Fri, 27 May 2022 17:32:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353650AbiE0PcY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 27 May 2022 11:32:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353648AbiE0PcX (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 27 May 2022 11:32:23 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C81F73631A
        for <linux-nfs@vger.kernel.org>; Fri, 27 May 2022 08:32:22 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24RDLXYj009396;
        Fri, 27 May 2022 15:32:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=0j2mlOZRG/ZvQqegkRX1v0Cc9MN0b+z3uTjnNj12oKk=;
 b=SkvHBtMei8nC5AcGynTwWiBtxnUxi2FzJ/HKuTdSY8IUUUypFcVDETthAH2WMxVpRNhQ
 NvsP3L9k0bzGZMSSFQ8Fr3+MDtPHrtCGoPL1yIKTBQnSVWcWRjTEQjlR96kHYdbPnbsH
 40SsqSNnIAnOgBTMJgvwTYm87nOkcFkDtJYcLoG2F8r+bX7AY9M/rUc3HwNjc7k5vt2h
 nsfbpgs76ZcRFOr/Z301rP89MN9NFQT/8fIoXfGsoUHfYPngT92t+okma4xr56mmANK5
 L/p/9uy8zEt+drTVQqM4kSQl/glsFLhbR3Fll795rj8NkBMgOGZDC2SqgIU13MM3psB8 Sw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g93t9ymay-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 May 2022 15:32:15 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24RFG3YG023514;
        Fri, 27 May 2022 15:32:14 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3g93x1u8s0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 May 2022 15:32:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iFS7oTj1UEothJJgl/zvaC/3/iBXC42Q25YrgdTQDPzdVhzySWw55mqtOLQuhKqnAD/G92/eWuiFgL/RYAL3XNPmhVTO91hYkQmEKC1CkC4UMpUE9QhSsQwwC8wFxAP/NZ0NBdWrgutN6S/9fhoioLRMp1/nqvjRhY0ofyAIXFEA4sH/vIGFk7uI0DvcLjc/R9aFFviP5A6CQDcT8L11sLQduUT7FV1eOyG+AvCPuKvT7WaWSLzfgUR0/JY7WvjPKVyV+RJKGjJxGr0w7ulkly/kU0PaMy11FFXB/v+ujIuyReKyG/Fl/w7DsY27sbxm8E1SsQOiralppKg2OjNHNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0j2mlOZRG/ZvQqegkRX1v0Cc9MN0b+z3uTjnNj12oKk=;
 b=kO02S/1gZnMNUe5K08c84lYbnq5ThRMLzjXvpBornfIpFnQfUnmubQkNsjTQhB9UBJWmRslom4SaleYSssXvTVDo1sk2naHu4J5OjiViO+I9Wx/k7XQYs/oEzs4yV6QYRL3SP3crvGPImJP1BV5Sn8tUi4HtWAJUFM0/ohNl1Uf5p1JysIjhTFzL0ACKmDhyFI6S0i9IY8Y5r1zhRVb/BEuc2DojPGJtMyJuqM7npdYTZdzJfHFX4fTvWt1+Q4uY4HkZNEu5Kwlb4scLK5mD7ckdt5Su2hhOMfgouNSe5vU4ZEfohq69vQv8JsDgSBXp0kAe2sKyrB0uADGhe6Z1rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0j2mlOZRG/ZvQqegkRX1v0Cc9MN0b+z3uTjnNj12oKk=;
 b=pRDll+CWi7NIvQtk7bjmU1IdhR5W2D61//3YsaukrzMm4s9kKq1QHz4JktkH9x2lFJh9OFKsflrpv75/xdb1WGFWKkhVm8j3SHb6NSgLdU0kTbB7O0HFPXedW6V/tfBNE3hIPEI4Ln1M9Y5guHqeH9E3pIH3dVKwiDWYeT4fhPk=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DM6PR10MB4043.namprd10.prod.outlook.com (2603:10b6:5:1d5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Fri, 27 May
 2022 15:32:12 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed81:8458:5414:f59f]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed81:8458:5414:f59f%9]) with mapi id 15.20.5293.016; Fri, 27 May 2022
 15:32:12 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Charles Hedrick <hedrick@rutgers.edu>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "trondmy@hammerspace.com" <trondmy@hammerspace.com>,
        Bruce Fields <bfields@fieldses.org>,
        Jeff Layton <jlayton@redhat.com>, Dai Ngo <dai.ngo@oracle.com>
Subject: Re: [PATCH RFC 0/2] Fix "sleep while locked" in RELEASE_LOCKOWNER
Thread-Topic: [PATCH RFC 0/2] Fix "sleep while locked" in RELEASE_LOCKOWNER
Thread-Index: AQHYZYF+q+AyM5Ko9UyH8L7ZZq5Gca0xn2sAgABJIoCAAAvUgIAA/nmA
Date:   Fri, 27 May 2022 15:32:12 +0000
Message-ID: <DB6B3676-32AF-43F0-9AC5-046A3E3F096B@oracle.com>
References: <165230584037.5906.5496655737644872339.stgit@klimt.1015granger.net>
 <PH0PR14MB549335582C7A4D4F4D2269B2AAD99@PH0PR14MB5493.namprd14.prod.outlook.com>
 <0387546F-0850-4BD3-B2DB-FCBEE1242610@oracle.com>
 <24401119-4BFD-4A27-BFE7-15FD92DA8FF6@rutgers.edu>
In-Reply-To: <24401119-4BFD-4A27-BFE7-15FD92DA8FF6@rutgers.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 297e9408-d0a6-4694-f94a-08da3ff61232
x-ms-traffictypediagnostic: DM6PR10MB4043:EE_
x-microsoft-antispam-prvs: <DM6PR10MB4043499E1EDA5C16A664EEA093D89@DM6PR10MB4043.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Hid2sfeBn3RLbbqVxlhaC90UqL2KMEToU+GNXjESvoK2t3TQJTJT5E5jKXQMFt1H8IQ6iTBRzP/+NQL8g44TiGxlttOiOZhVGlE+Wd8sQGRwmWTXWFwPAazSTAk3/Ch3zPGhYM4YkAGUWXTf4ul9aQnunqWKfPCysNAGjgibL11QfMFfIdcCcySklOuA5iIQ86G4rqufGa5kYLrEBtPZczC1MBYxnaTuXrzFnTsM7qdSGmNjDimsofmiTKcgVL4fK4Oxu/YcuYRanzv4tYtwExuKT+tedKYgW9/8EeqCLiEGWz+m3KMs0UBZszgkH3qa9DCr7/9Y6cp/EYYm8J/2CWpm2QQ16fMg+sEDWO4JipqEKee+XTKaqW6WZKWN634QKLXaSFG7xQldLZ7uGKbnFOrW/1H6i/zjprmA1bCXy+in56mQwC+kzYuh/qkJLdgNXXRGop1xYYv4cXrEtTms2p5BQWCHbzB/pnZREC/EjVZQy/kF7Jk6rf8/AYWoW9aXuI2bndRe5lBd4tVcMO5H7OxkrgbZ4SGl0xHJS41OvBjAJNg7WopSIx9lmCA6aIfiOxdPVnaAEIP4vf9YHjvFXu7FSA3pGyZU9U4s0EcoEBFTh+NKxMBsDvLY5wYJ6cITKs9HYsfs4LO/yvVb86tGj/otVqhZBjqd66SoKvRJ9Gqekie6la3JbAgZ5BGMGpfbTx+k7v4NINqdVKGsdINe3NjaD3L60qH051KiQVh7335ZEy5gOXI4C2al2MQRr45t
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(5660300002)(2616005)(107886003)(33656002)(8676002)(186003)(83380400001)(6512007)(53546011)(26005)(6506007)(8936002)(508600001)(71200400001)(6486002)(4326008)(38070700005)(38100700002)(86362001)(6916009)(316002)(54906003)(2906002)(122000001)(64756008)(66476007)(66446008)(66556008)(66946007)(91956017)(76116006)(36756003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VHZxNEZ5VnRNWGJ3UUxnWlJoUk01eEFER2RtY3F1OTZFbGtVdEVwSlQ5ZjRZ?=
 =?utf-8?B?NDlCNzdiVlI0a1BGWm9hbUR4Z3RNdUh2YmczVW5ORkptYmU4RXNnTzRUa21F?=
 =?utf-8?B?YnNXVmY0SjdEQnlTL0RZVDIrQ0tVbWI1S05XS3pRN2diQjUrSnlkMVV0K1do?=
 =?utf-8?B?eXI3eE8yS3pKbFhyQ3I5T2NCOWJuRWdmZjdhdmowS0Z1K3kyVGZIUi9Hd2dt?=
 =?utf-8?B?VHVIWVF4WW42dHBIOG4yWFZHbEVncnZuUEFjR3BCZUdiSDA1aURKQWtvSzJX?=
 =?utf-8?B?MjBicnZhdWZ1dXVIMGNCSU9YMUcwalFiTGhIcitwUitzaURxN0NDUEl2Yk9E?=
 =?utf-8?B?cy9UVFZUaGRzYlp2ak9GQTkxT0VuMFRZZEdOUDh3UnY1b0VQN3ppTlRMcWpp?=
 =?utf-8?B?UUM3cUc3Qy9SMGduUnpCVDEveVZwa05SME5jbXRVekl0OEpaelp0RGZaQ1FL?=
 =?utf-8?B?VVRpa0xnbFIxQmdsWVk2V280T0gvdUd4eW5nM2ZHalNCVENSazcrbEhrRlF0?=
 =?utf-8?B?cENFd2NXSnJjUm5HUVJEdll0blRwTk1oU3U1d2dVRTZtVHB6ZnRORE1pNVpV?=
 =?utf-8?B?ZjJPQXZTWGJBbjVqdmVMY2J0LzIxWTNpSGJrblYxK29QVFJHQzRmQ1FNVEcx?=
 =?utf-8?B?YzVORUxtZGFLenJGNG9wMEp5a2VCbUxTQW9hSjZ5Zm9uSTFPVWpTUy9CQmZv?=
 =?utf-8?B?TlR6dGhVK0M0MUhmamhXQS9JNmVUSkJpRmxYTTNCWUVuTEVRMmYvQ2RKdXp4?=
 =?utf-8?B?K1RJRENNaUM1eW9IblFHcURzWnJVVWRjZjhSaFQzazJKR2pnSGFPbkJ1OXFB?=
 =?utf-8?B?aENaQlN2cjMwU2ZGcUlrSmFLYWVWakgxQWdVM1dRazlGTTNRa0F6MFFiN0tF?=
 =?utf-8?B?dTUzM1pNRkN4Rnh4cWNyeVZ1aGVQbm5EVHFmNW1sTXVhUHMzT2pDYTdSb3F2?=
 =?utf-8?B?dVZmWjJkNlZZdTJXTHVoUmNCUUVseDVBelEzb2xYaDlGMC95cjk1bkhPT0dT?=
 =?utf-8?B?Y3RuTFlwcmZkRTdsUFdoOGhlejUrZW5pcUVuZlpHenk0REx3dVlTNmtSN3hp?=
 =?utf-8?B?clRVQWR5RFd6K2k3RmwyYjJlSU1PRlVmc2d6anRrZVpRT2hYSGFwMFJOL1dv?=
 =?utf-8?B?Rno4YWovVHRodFJYSG5FUVpqTW9VZ0VaYzU1N1Q4OFRnb2p3MU9YVUh1VlpO?=
 =?utf-8?B?YkV3QUcxUHVIZ1AwMUhiWmpOM1pxZjRQdExVc0p2T2dxbUlMRG9iNXhhMEd4?=
 =?utf-8?B?KzlOSlMrNmpmK3RXZEVHQ2tHTU01VjJrNnREUVFVaTZFTnl4OERtTHgrVkd0?=
 =?utf-8?B?RUMvM2FXc1l1QVk0WW1wcnVmbm9obUdLbGREd1JxWWMreC9iMW1pRGZwRHdR?=
 =?utf-8?B?R0RvK053U2dQZUFDTHRlUmQwWHRnY2ZMNmMzRXZpRUdLUjBzb2xwWnZoRlJ1?=
 =?utf-8?B?dldkcWx4TUdCaGNNSXVBZGN5MzNXVDRNTXdpSEVOVUVSQXlxUzUrNDdRN1Iv?=
 =?utf-8?B?c1p5MUl3N1NSNXpJbDJYSE5pQnpuSEgweGFmc3NoMFQzcFNkK05JaGdDeHpZ?=
 =?utf-8?B?QStzaGdtTHBVUjhCenF3b0tibnByZk9FMkdoTmc5WVk4cUtVUjI1SGw4SGp4?=
 =?utf-8?B?RXR2aUZ0WVU2RFpKQ2FWMFQwUGFjL2pNVU9Zb2RoK2ZLY3RTMUdJUVlEUVZM?=
 =?utf-8?B?TzhhU0JMRk95ckpoN2Z0UnFhWXQrVU9sVllIams4TzF0TFR6UEZ3Tlp4MFUw?=
 =?utf-8?B?Qk9Yc1B2OXF3bFREVW12RWNMcWk2OGxWVzkxUUJJTHhTVUxlV1VTcWFQNnhp?=
 =?utf-8?B?YmxzeXUyR2V6TG1aaUZWWU9jTlhUMyt3SUN1ekhpRlA5eURENjVJdU00YmhE?=
 =?utf-8?B?cHZoRWFzSnRwYjZRVGVNdHNBbUZJWWJBcTlBbkhlWkk4d0dZYjc5WjVXN3lX?=
 =?utf-8?B?TXFjdWlrNzJlaTRMRlRiek9pNEpHVTVYWGtpa0FUYjNKeUdKcHNKVFp0S1Ir?=
 =?utf-8?B?bk9MWjl3K2ZoMnBSYytJN1dtNmlVQkRuREF4bWIxak9NSEQ4bGZVQ2N1UnZI?=
 =?utf-8?B?dnQ1MlVLT3ZCbVpkVHg2R0Y5TFpuckQ2bkZEaHlNbnVnTnZSMkVHY2lEcld6?=
 =?utf-8?B?OVdmUjNxRnVVRm9FenJIbzNaclNTS2ptKzZoOGt6M3Y1OUtGMk53NEZ3L0NX?=
 =?utf-8?B?YUo3R1JVL1U4VFplMGw3MGluektDVXJIL2U2MGZ4eUtnOC9LSzZNZ2IzK1RT?=
 =?utf-8?B?cWx1RlluWUZJcGFwNVljVkhYaWJmUnppQnpzRjk0aXNKYzhjekJNRlg1QnNy?=
 =?utf-8?B?dU9sUXYwN0JVdnNWR2h0UVh4Wlk2eWthRkpOZTRlSkxxdFZOZzBsdE9Edy9O?=
 =?utf-8?Q?atXey0wPsOyV9Nwc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <412746F2D0E37442B73FDB7ECA6FF360@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 297e9408-d0a6-4694-f94a-08da3ff61232
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2022 15:32:12.5869
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZgjfvDSyFsEfnI0nV2kayvFMCzGyjhYTJtH21JkzN8mwbIVyaLZIUl7rhAM3V+hQ4j7Nu7WwWE/DQmsnPbM8Hw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4043
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.874
 definitions=2022-05-27_04:2022-05-27,2022-05-27 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2205270074
X-Proofpoint-ORIG-GUID: 5wRG7zaRanto4GlpHq2wf1fA0gEdp4Uw
X-Proofpoint-GUID: 5wRG7zaRanto4GlpHq2wf1fA0gEdp4Uw
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

DQoNCj4gT24gTWF5IDI2LCAyMDIyLCBhdCA4OjIxIFBNLCBDaGFybGVzIEhlZHJpY2sgPGhlZHJp
Y2tAcnV0Z2Vycy5lZHU+IHdyb3RlOg0KPiANCj4gSSB3YXMgaG9waW5nIGl0IHdhcyByZWFzb25h
YmxlIHRvIGFzayBmb3IgYmFja3BvcnRpbmcgdG8gdGhlIGxhdGVzdCBMVFMuDQoNCkl0IGlzIHJl
YXNvbmFibGUgZm9yIHlvdSB0byBtYWtlIHRoYXQgcmVxdWVzdCBvZiBzdGFibGVALCBjYzogbGlu
dXgtbmZzQC4NCihBbmQgeW91IGRvbid0IGhhdmUgdG8gaGlqYWNrIHNvbWVvbmUgZWxzZSdzIHRo
cmVhZCB0byBkbyB0aGF0IDstKQ0KDQpCdXQgZG8gbm90ZSB0aGF0IHVwc3RyZWFtIGNvbW1pdCA4
OWY0MjQ5NGY5MmYgIlNVTlJQQzogRG9uJ3QgY2FsbCBjb25uZWN0KCkNCm1vcmUgdGhhbiBvbmNl
IG9uIGEgVENQIHNvY2tldCIgaGFzIGFscmVhZHkgYmVlbiBiYWNrcG9ydGVkIHRvIHY1LjQuMTk2
DQphcyBjb21taXQgOTc1YTBmMTRkNWNkLiB2NS40LjE5NiB3YXMgcmVsZWFzZWQganVzdCB0d28g
ZGF5cyBhZ28uDQoNCkFuZCwgZndpdywgODlmNDI0OTRmOTJmIGhhZCBhIEZpeGVzOiB0YWcgaW4g
aXQuIFRoZSBzdGFibGUga2VybmVscyBoYXZlDQpzb21lIGF1dG9tYXRpb24gdGhhdCBsb29rIGZv
ciB0aGF0IGFuZCBhcHBseSBzdWNoIGNvbW1pdHMgYXV0b21hdGljYWxseS4NClNvbWV0aW1lcyBp
dCB0YWtlcyBhIHdoaWxlLCB0aG91Z2guDQoNCkdvb2QgbHVjay4NCg0KDQo+IEl0IHdvdWxkIGJl
IG5pY2UgaWYgeW91IGNvdWxkIG1ha2UgdGhlIHN0YXRlbWVudCB5b3UgZGlkIGFib3V0IHRoYXQu
IEF0IHRoYXQgcG9pbnQgSSBhZ3JlZSB0aGF0IGl04oCZcyBVYnVudHXigJlzIHByb2JsZW0uDQo+
IA0KPj4gT24gTWF5IDI2LCAyMDIyLCBhdCA3OjM5IFBNLCBDaHVjayBMZXZlciBJSUkgPGNodWNr
LmxldmVyQG9yYWNsZS5jb20+IHdyb3RlOg0KPj4gDQo+PiDvu78NCj4+IA0KPj4+IE9uIE1heSAy
NiwgMjAyMiwgYXQgMzoxNyBQTSwgQ2hhcmxlcyBIZWRyaWNrIDxoZWRyaWNrQHJ1dGdlcnMuZWR1
PiB3cm90ZToNCj4+PiANCj4+PiBXZSBhcmUgc3RpbGwgc3R1Y2sgb24gTkZTIDMgYmVjYXVzZSBO
RlMgNCBsb2NrIG9wZXJhdGlvbnMgaGFuZy4gVHlwaWNhbGx5IHdpdGggdGh1bmRlcmJpcmQsIGZp
cmVmb3gsIGV0Yy4gSSBoYWQgaG9wZWQgdGhhdCBVYnVudHUgMjIgd291bGQgZml4IHRoaXMsIGdp
dmVuIHRoZSBwYXRjaCANCj4+PiANCj4+PiBVTlJQQzogRG9uJ3QgY2FsbCBjb25uZWN0KCkgbW9y
ZSB0aGFuIG9uY2Ugb24gYSBUQ1Agc29ja2V0DQo+Pj4gDQo+Pj4gSWYgdGhpcyBpcyBwYXJ0IG9m
IHRoZSBwcm9ibGVtLCB0aGF0IHdvdWxkIG1lYW4gd2UgY291bGRuJ3QgdXNlIE5GUyA0IHVudGls
IFVidW50dSAyNCwgaS5lLiBzdW1tZXIgb2YgMjAyNSwgZ2l2ZW4gZGVsYXlzIGluIHJlbGVhc2Ug
YW5kIGRlcGxveW1lbnQuDQo+Pj4gDQo+Pj4gVW5mb3J0dW5hdGVseSBJIGNhbid0IHJlcHJvZHVj
ZSBvdXIgcHJvYmxlbS4gSXQgZG9lc24ndCBzaG93IHVwIHVudGlsIHdlJ3JlIGhhbGZ3YXkgaW50
byBvdXIgc2VtZXN0ZXIgYW5kIGxvYWRzIHN0YXJ0IGdldHRpbmcgaGVhdmllci4NCj4+PiANCj4+
PiBZb3Ugc2F5IHRoaXMgaXMgYSBsb25nLXN0YW5kaW5nIGlzc3VlLiBTbyBhcmUgcHJvYmxlbXMg
d2l0aCBORlMgNCBsb2NraW5nIChhbmQgYWxzbyBORlMgNCBkZWxlZ2F0aW9uKS4gSWYgeW91IGhh
dmUgYSBwYXRjaCBmb3IgYm90aCBvZiB0aGVzZSBpc3N1ZXMgdGhhdCB3ZSBjb3VsZCBwdXQgaW50
byA1LjQuMCwgSSBtaWdodCBiZSB3aWxsaW5nIHRvIHRlc3QgaXQsIGFzc3VtaW5nIHRoZSBwYXRj
aGVzIGFyZSBzYWZlLiBXZSBwcm9iYWJseSB3b3VsZG4ndCBrbm93IGl0IGhhcyByZWFsbHkgZml4
ZWQgdGhpbmdzIGZvciBhdCBsZWFzdCA2IG1vbnRocy4NCj4+IA0KPj4gQ2hhcmxlcywgdGhpcyBt
YWlsaW5nIGxpc3QgaXMgYW4gdXBzdHJlYW0gTGludXggZm9ydW0uIFRoZXJlIGhvbmVzdGx5IGlz
bid0IGFueXRoaW5nIHdlIGNhbiBkbyBhYm91dCBVYnVudHUgYmFja3BvcnRpbmcgcG9saWNpZXMs
IGFuZCB3ZSBjYW4ndCBoZWxwIG11Y2ggYXQgYWxsIHdpdGggTGludXgga2VybmVscyBhcyBvbGQg
YXMgdjUuNCB1bmxlc3MgdGhlcmUgYXJlIGtub3duIGZpeGVzIGluIGxhdGVyIGtlcm5lbHMuIEl0
J3MgdXAgdG8geW91IHRvIGZpbmQgdGhvc2UgZml4ZXMsIHRlc3QgdGhlbSwgYW5kIHRoZW4gY29u
dmluY2UgdGhlIHN0YWJsZSBrZXJuZWwgZm9sa3MgYW5kIHlvdXIgZGlzdHJpYnV0aW9uIHRvIGlu
Y2x1ZGUgdGhlIGZpeCBpbiB0aGVpciBrZXJuZWwuIFRoZSBmb2xrcyBvbiBsaW51eC1uZnNAIGFy
ZSBsaXR0bGUgbW9yZSB0aGFuIHByb2Nlc3Mgb2JzZXJ2ZXJzIGluIHRob3NlIGNvbW11bml0aWVz
Lg0KPj4gDQo+PiBUaGUgUkVMRUFTRV9MT0NLT1dORVIgbG9jayBpbnZlcnNpb24gaXNzdWUgaGFz
IGJlZW4gYXJvdW5kIGZvcmV2ZXIsIGJ1dCBpdCB3YXMgZXhwb3NlZCByZWNlbnRseSBieSBhIHBl
cmZvcm1hbmNlIHJlZ3Jlc3Npb24gZml4IGluIHY1LjE4LXJjMy4gQWZ0ZXIgdGhhdCBwb2ludCwg
YSBjbGllbnQgY2FuIGxldmVyYWdlIHRoZSBleGlzdGluZyBsb2NrIGludmVyc2lvbiBidWcgdG8g
cHJvdm9rZSBhIGRlYWRsb2NrIG9uIHRoZSBzZXJ2ZXIgdXNpbmcgbm9ybWFsIE5GU3Y0IG9wZXJh
dGlvbnMuIFRoYXQgbWFrZXMgdGhlIFJFTEVBU0VfTE9DS09XTkVSIGlzc3VlIGEgcG90ZW50aWFs
IGRlbmlhbC1vZi1zZXJ2aWNlIGluIHRoZSBsYXRlc3Qga2VybmVscywgd2hpY2ggaXMgcHJpb3Jp
dHkgb25lIGluIG15IGJvb2suDQo+PiANCj4+IEkgc3RhbmQgYnkgbXkgc3RhdGVtZW50IHRvIExp
bnVzIGluIHRoaXMgbW9ybmluZydzIHB1bGwgcmVxdWVzdDogSSBjdXJyZW50bHkga25vdyBvZiBu
byBvdGhlciBoaWdoIHByaW9yaXR5IGJ1Z3MgaW4gdjUuMTgncyBORlMgc2VydmVyIChJJ20gbm90
IHRhbGtpbmcgYWJvdXQgdGhlIE5GUyBjbGllbnQpIHVuZGVyIGFjdGl2ZSBpbnZlc3RpZ2F0aW9u
IGV4Y2VwdCBmb3IgdGhlIG9uZSBJIG1lbnRpb25lZCBpbiB0aGUgUFIuIElmIHlvdSBrbm93IG9m
IC9zcGVjaWZpYy8gcmVwb3J0cyBvZiBzaWduaWZpY2FudCBpbmNvcnJlY3QgYmVoYXZpb3IgaW4g
dGhlIGxhdGVzdCB1cHN0cmVhbSBMaW51eCBORlMgY2xpZW50IG9yIHNlcnZlciwgcGxlYXNlIHBv
c3QgbGlua3MgdG8gdGhlbSBoZXJlLCBvciBiZXR0ZXIgeWV0LCBmaWxlIGJ1Z3MgYW5kIGhlbHAg
dGhlIGFzc2lnbmVlcyB0byB0cm91Ymxlc2hvb3QgdGhlIHByb2JsZW1zLg0KPj4gDQo+PiANCj4+
IC0tDQo+PiBDaHVjayBMZXZlcg0KPj4gDQo+PiANCj4+IA0KDQotLQ0KQ2h1Y2sgTGV2ZXINCg0K
DQoNCg==

Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C4E7765E62
	for <lists+linux-nfs@lfdr.de>; Thu, 27 Jul 2023 23:48:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232340AbjG0Vsd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 27 Jul 2023 17:48:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbjG0Vsc (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 27 Jul 2023 17:48:32 -0400
Received: from mx0e-00379502.gpphosted.com (mx0e-00379502.gpphosted.com [67.231.147.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 141D52135
        for <linux-nfs@vger.kernel.org>; Thu, 27 Jul 2023 14:48:30 -0700 (PDT)
Received: from pps.filterd (m0218361.ppops.net [127.0.0.1])
        by mx0f-00379502.gpphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36RJFj8K000667;
        Thu, 27 Jul 2023 14:48:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=llnl.gov; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=02022021-podllnl;
 bh=uwOBNs2hNV1NbhjLFdGN17UEmv2f8n/R6eppCUxWufs=;
 b=isAjREkE1aBLDwmlpepkTq/F1oR+R6CZNFRawDAM9UWU5dmAyluiZougxrVcXydHw3Qr
 /y4BN2oPH+UM5mO3Ck6cCE0u1sJX1YWoavn/LdmeqdSm9vgMJSS7hKQGyhDIWRzAYxw2
 G/WaP99FUCCE+sigyaba3VZ098cA+AmnvcDdqAVutBMD+NI0umzcvRq8t5XkVMN+J0TR
 HBE+0qyjrEPAFLOD65+yX47bm4Ui3KbhNhJMPfsEJirz0Rnv9RnwDUJ0ctPb3pka7jNo
 7VC/eqYZso0kIvy3+OO0cAkiAeNMGi3nAQuBsg2neloJtdevoqpZwNAXeyJ5ho9zopCC Gg== 
Received: from gcc02-bl0-obe.outbound.protection.outlook.com (mail-bl2gcc02lp2101.outbound.protection.outlook.com [104.47.64.101])
        by mx0f-00379502.gpphosted.com (PPS) with ESMTPS id 3s3xk28h8p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Jul 2023 14:48:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V2C9q3ejXH+2Wh4d4isEIWa+shgTAuIMuqUIiytz4zKXN+dcRTc1IvlAE9JNljIUN+g7YcTkuUbFgbb3lOMDJhWbWpVZbExMSjMjEWY2u83OvGkkXozgc2BcffTu+2Pdo/an12VQv4ksh+8OYTqtydmAjxkYf9t5iPfr0AtQ3n1UIiJJ4OiHo2uS/27tv07YXgaQ7fNH4RFSSK6DfgaNuUIIKejDb2iHwZ6Z71GSzPykdbtkLpBo6usxYRPeBePLReoz3U/08E2Q1umZwDkbD4khBG4W3SDisTOlowZRpiKZR7wOF/jn3oUt2o8Fp+uL57LfuSjzbYrGyJTf+gQpaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uwOBNs2hNV1NbhjLFdGN17UEmv2f8n/R6eppCUxWufs=;
 b=AJ9Sgf9tLtZ3aGU/2hk9/pAaytNvhw4s7aq9IJFjigMec4izUGAbOG4+qgwbbD/PUMoyPllc9H4XU98ViJP1hqW+6P+R7z6VddsvgAeTU8gBRgdtYR/g2KQopgjUDmdKH5d9OrzFLhSorOk9pYl3xoqGi8EHvNjoPEqjs5UyZy57lhIsTzRfRw2/oeGZdS7dNJhx/suDCyHz84JW9h5upcUZU+Ikf1SpLuye9OzyJCguiItAOOEZvf5FjxBTuNEmcKGvS2y9XojYIJqfsoCkp8PCc54uk8/gTZ17DH4gBJwSzXOZJyzE0fhB9YXCackWSy8agW3/bWw4VYtsKhSrag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=llnl.gov; dmarc=pass action=none header.from=llnl.gov;
 dkim=pass header.d=llnl.gov; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=doellnl.onmicrosoft.com; s=selector1-doellnl-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uwOBNs2hNV1NbhjLFdGN17UEmv2f8n/R6eppCUxWufs=;
 b=ApIq+QXf7jC1egOkKqzaM3UrVn1U6pCykwa/0FI45RfgWvEkAXmRatnDvau0OS1Q697r5r4lNoBazgllLJ9QBo3v/hFfn/I/SwWNlZHs63iubgVEpqOZnhxxtl6DFMSeH0Vi6d0S+U/qghzkT6uamcFBuSvndOq91Dvgf5AYGhk=
Received: from BY5PR09MB5009.namprd09.prod.outlook.com (2603:10b6:a03:249::22)
 by SA1PR09MB11802.namprd09.prod.outlook.com (2603:10b6:806:361::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 21:48:23 +0000
Received: from BY5PR09MB5009.namprd09.prod.outlook.com
 ([fe80::1d54:a809:23b3:1f62]) by BY5PR09MB5009.namprd09.prod.outlook.com
 ([fe80::1d54:a809:23b3:1f62%3]) with mapi id 15.20.6631.026; Thu, 27 Jul 2023
 21:48:23 +0000
From:   "Wartens, Herb" <wartens2@llnl.gov>
To:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
CC:     "steved@redhat.com" <steved@redhat.com>
Subject: Re: Double-Free and Memory Leak Found In libtirpc
Thread-Topic: Double-Free and Memory Leak Found In libtirpc
Thread-Index: AQHZwKSTAQS1nermGkeU53rtxELPta/OJssA
Date:   Thu, 27 Jul 2023 21:48:23 +0000
Message-ID: <968E8957-2AF6-4901-84B0-92EDB5791131@llnl.gov>
References: <E931E05A-A78D-4802-9877-B04E9F610817@llnl.gov>
In-Reply-To: <E931E05A-A78D-4802-9877-B04E9F610817@llnl.gov>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.600.7)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR09MB5009:EE_|SA1PR09MB11802:EE_
x-ms-office365-filtering-correlation-id: 9c53f3b4-6461-486b-e0fe-08db8eeb33a2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FLYEWjmfboZfDnkqCv/bd0x1W8SqD9WBK+eZA+rMDM3Vf5MSvIb50rpiPAvmY7Un1EvflLzqu8irc+p+L0bbDDUt2ssjrzL5JD1CVFNa/jN4RcYT1jPyqtHEjDMGf1dVIlKJsCMs9n2/3gd/OqTB8EyKGHhb95JrEddRNHI485EubIJXJZqmeY+hNL7pKAjeUX6X8fG3kTEqsUv1PDorXAEN8uIoTuu85/JB2LRud0YuieQM/bLyY80vH9ul1AvOV41CH7fxavj+acajWF1jKTlmGN/utsF4Adt9totcruK1OPh8wIAUT+HS3+eBWxRYXq7XkP+VdsHG2i4Fcljj5LF1oYWIXyJnxPSc8WC3ntdsC/f0/n7vDy3u67LUzvMymW3XX2wVBNk1l42WBNgcpgUfuznBQ3mfLuZQGLXBizBCiJ1DhWX25N9ALypZ690ryltBuSXle3xqRsLT1Q/lNVpIvBoEbHR5h1cQrOlzot66G9Se7zxY+hvTNj2pYrnLoFTzOxMXBYynv7Y2Taak3u8rokNsmVrphIKtmVIF+H6AQXaDpK/9CxMCpnW/bQygS0mBlZP4OHb/gl+9Enjm4Ckz3dH4DzMXd4W58jbMF7haX0c2+cfQvR7LYJG06ejB1tMSJFOL1KwkDhtsb3mzeA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR09MB5009.namprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(451199021)(71200400001)(6506007)(26005)(186003)(2906002)(4326008)(6916009)(82960400001)(38070700005)(8676002)(8936002)(36756003)(86362001)(6486002)(966005)(6512007)(498600001)(38100700002)(64756008)(122000001)(33656002)(66556008)(5660300002)(76116006)(66946007)(66476007)(66446008)(83380400001)(53546011)(2616005)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SDZ4NkhHdGNaUFg1VlFkVFdsWjlEeUluaDNFOXdMWVhXNktDUnMzUjg4bWoz?=
 =?utf-8?B?TmJWOHUzbFlnSm5wcmVPZ3R2bWtMSTZ4OGhJQ04wc3ptdkZXWkkxYllwTnBh?=
 =?utf-8?B?UndXZjBBZ2JueDBLSXoraTVPdkJFV0ZMSEwvUjVmM1g2YXNVOUN3OG5oQ0hZ?=
 =?utf-8?B?TlhBQVgxOGpJNzBUT1NhZTZsb0psVS9lc1VXeE9xQjN2UTFGbU4rdlE2bGxY?=
 =?utf-8?B?SGM2aXNQeUh3Q1ZRcW5FcmI2RDJQZll1S09KeTN5ZHdWM1BrM01wL2dnTG9r?=
 =?utf-8?B?QmFJTGJYVS9DZys3clV2U090dHJCYWlvMHVpbkNENVZiSmpPNjhuUjluZmFz?=
 =?utf-8?B?Y0NHOFp3WEVJdXF0YzUvQmIxWUU3Vkt5d0IxTEFKbzBLQ3d2YmJWRkxMdGIy?=
 =?utf-8?B?VGF3LzByamwzVHB2NEtFWWRrSFhmRkFZVEQrZnFPRUNBa2haNmo3OGhsWjN3?=
 =?utf-8?B?OXZJVWZMbEJhclBGaGVRbGtROWxRVDgvazVzMUhTMVRUcDNocTlRWEVyS0No?=
 =?utf-8?B?KzhxL0E1VXpsYUlQUS9HOXgxb2ZzcVFZeldYSjZ6Ly9HeGZ3dHUrREJhdytw?=
 =?utf-8?B?V3F0V0xEU0ZwSVk4VUR0YUVHVjlUNkhZSUdrblVqbzlNVk9pZnUvUkpuSkFR?=
 =?utf-8?B?ZVFOOFJRQlNTcUY1dDJ1bFc2cXc3SENNTElVQmFDQklZSnFvcTVCRm1YdWVj?=
 =?utf-8?B?WjQwWEdxclA2Q2MrVUV4UzhSQ0xISUpLVVdhcXVDTVJXWmFiaGZtVWFuUDRz?=
 =?utf-8?B?TEVTN1JxNW0vZTR2SkhETTF5VlRYMXRDYllyVmIweTcwWlhEMVlNUE5GNERP?=
 =?utf-8?B?eXFOejZLd1BDa0plUXBNMkZka3JjYzd6OUJGei9zQ0xiWVpUTThJbmJwZTJV?=
 =?utf-8?B?eVBvOEJoZTh5S1g2WUxjL1hCbVNqNDZWUWt6ZlVsWDJLZFV2ZERIdVZOYU5I?=
 =?utf-8?B?L01jVDFDOURwSDYzT0JmaFF1OGdBNmFHRFZWOU5URFFFWC92M0FhcFhITW5T?=
 =?utf-8?B?V3ZRZUFJTXdMMjZrV1NqTWU5c2VqMStnL0xzUCtpenJYU2pvbVlreVg5Rzl1?=
 =?utf-8?B?Tm1JcnVLZ1VRak12VWREdWkzNU5CajFhUzhYWitVV0JvOE9VbXZ6WmlRemNN?=
 =?utf-8?B?V1FPRFVPNWh0dUQ0U2VrR2NYdzBYT3ZlWFNXWjdsTEx6RC9MNXFZSFR3NDhR?=
 =?utf-8?B?NldvdlJCOTBMOGdTNis1bDltZzhLZWJTYzUzTzdsaHNqYUNoMVlINlErQ1RI?=
 =?utf-8?B?b3dNeTZRZUdmck52dDNJZmNGaURnVmIyaUp6YWx5dVgvaVFzcTNVWktQZy9p?=
 =?utf-8?B?K04zazViV0xCUWZkc0NaRi96NW5ZTEtBbUh4UDAyeHFlcG9KNFhWVVFkSDM3?=
 =?utf-8?B?aXE5ODVraExFd0pRYU1mSnVxWCtVOHA5L2U4dTk4YlYwdjNLdytHVjNnZEN6?=
 =?utf-8?B?VHdrTTd0Ui8weXJPM0M5aUFaakNGNEhEa0s3WUQ4dTM1NG41VjVqQkZJcUV1?=
 =?utf-8?B?M2VpQ2Z4MUVhQ0JoazhGQmVpUldRTVNGRDk5SU9sSW5pbFJEVDc4dTl5bnR2?=
 =?utf-8?B?Z0VYVm5JWkRXYjFrNzhvc1ZVbnNORmFJcERNY0JXZFdUd1ZVT05MdVlkOFR6?=
 =?utf-8?B?cEZhTTJyUi8rUGVsTmNOZkNyeHF0eUdSWkdNazZnZE45WkkydEVrdHIyKzlF?=
 =?utf-8?B?R3IzNHVzYUd6TXdDVEhWUGprMXBHaXJDN1RnZmEra1FJUXBwVkc2dXRTMUYw?=
 =?utf-8?B?S1lBRHN3SjV1Vkl0S09XWHBMRU04Qjl1Z0RxTVJoT1ZWb2ZVeVBsWnZiR3R0?=
 =?utf-8?B?cUR0QXRoKzR6ME15aG9ReGw0b0ZWUzh2SWdCUFJnRDdKSmNiVkN2K1h1cFpU?=
 =?utf-8?B?d0J6enRrbXNaSEtnbisrWHlPR1JrMTdwME9aY0hHdVFyNzFzWGNGNUMyY0Vu?=
 =?utf-8?B?SEJaK0srQ0I0WGFtcVJhNXd4WDNPTW1QY0h4VW1ObzF1ZCtsV3UwclRkOEh0?=
 =?utf-8?B?MUF0WXcxNmhDMGRobHhOWUdCa2pUejV1UmdhVU9iOFFVbElIcjBOK3JMd3hs?=
 =?utf-8?B?a29Bb2NEVW5OVzNKNmd3OWoyQWR5QXljUFNCcTVtM2w0NGVwTW1Gb0p0NjQw?=
 =?utf-8?Q?/aNQ3xGfj2+XIZyEuJUkVuXD+?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <190D5C1BA77A1A4A954649A30C847E01@namprd09.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: V0aLbSXz0Y4aeIYHIlzJTyMkD121j2SyD2T2iApBPLA32Ds23jtSTM4wr5wG1AEpNxEPOlhlIrPxQ/xJ5oMvUysCrM/HfW1RUjaAGsG2A7kx7ZBlwSkIWsQKyaOsS+1Ji7EdR6fg0bOEAv8O03aTii16uHuRpzNFbzxKnEdhRaAi8HcAAGuN7wz6pmoXZ9+J/xRFkTiPOrwpssPDmrib2xph46WBFVselUHj4xbznES6oIGFTeA9gLi7nTPbjJzrEBl1EdVuznlLvBqyIC0O8xBcR0nGaGKX4W1KwV/u1RUwwsWP6SExuibo6K5zoyKz9SQgQYdAQ4tCRxZOFygv+vZsDl2z1DYcigiED+4sZj1Qi15SN7S6baHr39mJp/5crOZ4aY1o1hdigeM6QcgnFj2N2p0mMJO56GjkHjal8TVJo30iaM3cHVyp1dMNcLqYzyiN5CGY70XihmqBt6iwpYyXufpnj23fHmGqiFU5ZmEwH0DFwlbIwCIc3LFDX9dXGPFEX2SBVyeL41ETE5x0hBtH7uOdw5zC1kYdjURv12dlas1MI9GC5thdHAuonQsoXmIHoCJJm69yRdOmTZ4KRaoxgRj3BlaxRgeBArJpk/ATi4XYUDAvHS5mCmMmOP7kgDWhe1aqCK16OQjRWq/bhpj7q1HmJHS2vdYEGmiCV1fvn6QYdGt7G7JybK2ErBmpwHFuzqVi/ksOcSUsSrNLc/ItMflzMxM6kpI3bH3Y6n5PPMnWfpVfEdAz6hR0xC7VJK08cVfes7dfN7y7ntF4pcCN3Vx6m2JPEwyUlXXNTtcw2I7eOe6xx7R2YGUIyhgb
X-OriginatorOrg: llnl.gov
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR09MB5009.namprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c53f3b4-6461-486b-e0fe-08db8eeb33a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2023 21:48:23.7457
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a722dec9-ae4e-4ae3-9d75-fd66e2680a63
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR09MB11802
X-Proofpoint-ORIG-GUID: RnKA30CPh7hllqPNZUpKq67mWHnESpEP
X-Proofpoint-GUID: RnKA30CPh7hllqPNZUpKq67mWHnESpEP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-27_10,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1015
 spamscore=0 malwarescore=0 suspectscore=0 mlxlogscore=999 adultscore=0
 lowpriorityscore=0 priorityscore=1501 mlxscore=0 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307270198
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_GOV_DKIM_AU,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

DQpKdXN0IHRvIGJlIGNsZWFyLi4uDQpUaGVzZSBwYXRjaGVzIHdlcmUgbm90IG1hZGUgZm9yIHRo
ZSB1cHN0cmVhbSBicmFuY2ggKG1pZ2h0IG5vdCBhcHBseSBhcyBjbGVhbmx5IGFzIGV4cGVjdGVk
KS4gSSBhcHBsaWVkIGFuZCB0ZXN0ZWQgdGhlbSBhZ2FpbnN0IGxpYnRpcnBjLTEuMS40LTguZWw4
LiBJIGhhdmUgbm90IGdvbmUgdGhyb3VnaCB0aGUgdHJvdWJsZSBvZiB2ZXJpZnlpbmcvdGVzdGlu
ZyB0aGVtIGFnYWluc3QgdXBzdHJlYW0gc291cmNlcy4gV2FzIGp1c3QgYXNrZWQgdG8gbWFpbCB0
aGVzZSBwYXRjaGVzIGhlcmUgYnkgUkggaW4gdGhlIGJ1Zy4gSG9wZWZ1bGx5IHRoaXMgaXMgc3Rp
bGwgaGVscGZ1bC4NCg0KLUhlcmINCg0KDQo+IE9uIEp1bCAyNywgMjAyMywgYXQgOTowOCBBTSwg
V2FydGVucywgSGVyYiA8d2FydGVuczJAbGxubC5nb3Y+IHdyb3RlOg0KPiANCj4gSGVsbG8gQWxs
LA0KPiBXZSBoYXZlIG9wZW5lZCB1cCB0d28gc2VwYXJhdGUgUmVkSGF0IGJ1Z3MgZm9yIHRoZXNl
IGlzc3Vlcy4gSSBhZGRlZCBwYXRjaGVzIHRvIHRob3NlIGJ1Z3MsIGJ1dCB3YXMgYXNrZWQgdG8g
c2VuZCB0aGUgcGF0Y2hlcyBoZXJlIGFzIHdlbGwgc2luY2UgdGhlIHBhdGNoZXMgbWlnaHQgbmVl
ZCB0byBnbyB1cHN0cmVhbSBmaXJzdC4NCj4gDQo+IDEpIGh0dHBzOi8vYnVnemlsbGEucmVkaGF0
LmNvbS9zaG93X2J1Zy5jZ2k/aWQ9MjIyNDY2Ng0KPiANCj4gV2UgaGF2ZSBhbiBhcHBsaWNhdGlv
biBjYWxsZWQgSFBTUyB0aGF0IGhlYXZpbHkgdXNlcyBsaWJ0aXJwYy4gV2hlbiB3ZSB1cGRhdGVk
IHRvIFJIRUw4Ljggb3VyIGFwcGxpY2F0aW9uIHN0YXJ0ZWQgY3Jhc2hpbmcgYWxsIG9mIGEgc3Vk
ZGVuLiBXZSBiZWxpZXZlIHRoZSBjaGFuZ2UgdGhhdCBpbnRyb2R1Y2VkIHRoaXMgcHJvYmxlbSB3
YXMgMjExMjExNjoNCj4gDQo+IDIwMjItMDgtMDMgU3RldmUgRGlja3NvbiBtYWlsdG86c3RldmVk
QHJlZGhhdC5jb20gMS4xLjQtOA0KPiAtIHJwY2JfY2xudC5jIGFkZCBtZWNoYW5pc20gdG8gdHJ5
IHYyIHByb3RvY29sIGZpcnN0IChieiAyMTA3NjUwKQ0KPiAtIE11bHRpdGhyZWFkZWQgY2xlYW51
cCAoYnogMjExMjExNikNCj4gDQo+IDI1MiAgICAgZm9yIChjcHRyID0gZnJvbnQ7IGNwdHIgIT0g
TlVMTDsgY3B0ciA9IGNwdHItPmFjX25leHQpIHsNCj4gMjUzICAgICAgICAgaWYgKCFtZW1jbXAo
Y3B0ci0+YWNfdGFkZHItPmJ1ZiwgYWRkci0+YnVmLCBhZGRyLT5sZW4pKSB7DQo+IDI1NCAgICAg
ICAgICAgICAvKiBVbmxpbmsgZnJvbSBjYWNoZS4gV2UnbGwgZGVzdHJveSBpdCBhZnRlciByZWxl
YXNpbmcgdGhlIG11dGV4LiAqLw0KPiAyNTUgICAgICAgICAgICAgaWYgKGNwdHItPmFjX3VhZGRy
KQ0KPiAyNTYgICAgICAgICAgICAgICAgIGZyZWUoY3B0ci0+YWNfdWFkZHIpOw0KPiAyNTcgICAg
ICAgICAgICAgaWYgKHByZXZwdHIpDQo+IDI1OCAgICAgICAgICAgICAgICAgcHJldnB0ci0+YWNf
bmV4dCA9IGNwdHItPmFjX25leHQ7DQo+IDI1OSAgICAgICAgICAgICBlbHNlDQo+IDI2MCAgICAg
ICAgICAgICAgICAgZnJvbnQgPSBjcHRyLT5hY19uZXh0Ow0KPiAyNjEgICAgICAgICAgICAgY2Fj
aGVzaXplLS07DQo+IDI2MiAgICAgICAgICAgICBicmVhazsNCj4gMjYzICAgICAgICAgfQ0KPiAy
NjQgICAgICAgICBwcmV2cHRyID0gY3B0cjsNCj4gMjY1ICAgICB9DQo+IDI2Ng0KPiAyNjcgICAg
IG11dGV4X3VubG9jaygmcnBjYmFkZHJfY2FjaGVfbG9jayk7DQo+IDI2OCAgICAgZGVzdHJveV9h
ZGRyKGNwdHIpOw0KPiANCj4gc28gd2UgaGF2ZSBmcmVlJ2QgY3B0ci0+YWNfdWFkZHIuIEkgYmVs
aWV2ZSBhZnRlciB0aGF0IGZyZWUgcHJvYmFibHkgc2FmZXIgdG8gc2V0IGNwdHItPmFjX3VhZGRy
IHRvIE5VTEwuDQo+IE5vdGUgdGhhdCBkZXN0cm95X2FkZHIoKSB3aWxsIGFsc28gdHJ5IHRvIGZy
ZWUgaXQuDQo+IA0KPiAyKSBodHRwczovL2J1Z3ppbGxhLnJlZGhhdC5jb20vc2hvd19idWcuY2dp
P2lkPTIyMjUyMjYNCj4gDQo+IFdoaWxlIGluc3BlY3RpbmcgdGhlIGNoYW5nZXMgYmV0d2VlbiB0
aGUgdmVyc2lvbnMgb2YgbGlidGlycGMgaW4gcXVlc3Rpb24sIEkgbm90aWNlZCBhIG1lbW9yeSBs
ZWFrIGFzIHdlbGwuDQo+IA0KPiAvKg0KPiArICogRGVzdHJveXMgYSBjYWNoZWQgYWRkcmVzcyBl
bnRyeSBzdHJ1Y3R1cmUuDQo+ICsgKg0KPiArICovDQo+ICtzdGF0aWMgdm9pZA0KPiArZGVzdHJv
eV9hZGRyKGFkZHIpDQo+ICsgICAgICAgc3RydWN0IGFkZHJlc3NfY2FjaGUgKmFkZHI7DQo+ICt7
DQo+ICsgICAgICAgaWYgKGFkZHIgPT0gTlVMTCkNCj4gKyAgICAgICAgICAgICAgIHJldHVybjsN
Cj4gKyAgICAgICBpZihhZGRyLT5hY19ob3N0ICE9IE5VTEwpDQo+ICsgICAgICAgICAgICAgICBm
cmVlKGFkZHItPmFjX2hvc3QpOw0KPiArICAgICAgIGlmKGFkZHItPmFjX25ldGlkICE9IE5VTEwp
DQo+ICsgICAgICAgICAgICAgICBmcmVlKGFkZHItPmFjX25ldGlkKTsNCj4gKyAgICAgICBpZihh
ZGRyLT5hY191YWRkciAhPSBOVUxMKQ0KPiArICAgICAgICAgICAgICAgZnJlZShhZGRyLT5hY191
YWRkcik7DQo+ICsgICAgICAgaWYoYWRkci0+YWNfdGFkZHIgIT0gTlVMTCkgew0KPiArICAgICAg
ICAgICAgICAgaWYoYWRkci0+YWNfdGFkZHItPmJ1ZiAhPSBOVUxMKQ0KPiArICAgICAgICAgICAg
ICAgICAgICAgICBmcmVlKGFkZHItPmFjX3RhZGRyLT5idWYpOw0KPiArICAgICAgIH0NCj4gKyAg
ICAgICBmcmVlKGFkZHIpOw0KPiArfQ0KPiANCj4gUHJldHR5IGNsZWFyIHRoYXQgYWRkci0+YWNf
dGFkZHIgbmV2ZXIgd2FzIHByb3Blcmx5IGZyZWXigJlkLiBJIGFsc28gdmVyaWZpZWQgdGhhdCB3
aXRoIHZhbGdyaW5kLg0KPiANCj4gSSBhbSBoYXBweSB0byBhZGQgbW9yZSBkZXRhaWwsIGJ1dCBo
b3BlZnVsbHkgb3RoZXJzIG9uIHRoaXMgbGlzdCBjYW4gYWNjZXNzIHRoZSBidWdzIGluIHF1ZXN0
aW9uLiBJZiBub3QgbGV0IG1lIGtub3cgYW5kIEkgY2FuIGFkZCBtb3JlIGRldGFpbCBoZXJlIGlm
IG5lZWRlZC4gVGhhbmtzLg0KPiANCj4gLUhlcmINCj4gDQo+IDxsaWJ0aXJwYy0xLjEuNC1MTE5M
LW1lbWxlYWsucGF0Y2g+PGxpYnRpcnBjLTEuMS40LUxMTkwtY3Jhc2gucGF0Y2g+DQoNCg==

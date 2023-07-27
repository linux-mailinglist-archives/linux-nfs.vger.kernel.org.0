Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5252276584B
	for <lists+linux-nfs@lfdr.de>; Thu, 27 Jul 2023 18:08:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232064AbjG0QIg (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 27 Jul 2023 12:08:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232129AbjG0QIf (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 27 Jul 2023 12:08:35 -0400
Received: from mx0f-00379502.gpphosted.com (mx0f-00379502.gpphosted.com [67.231.155.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2131910B
        for <linux-nfs@vger.kernel.org>; Thu, 27 Jul 2023 09:08:31 -0700 (PDT)
Received: from pps.filterd (m0218362.ppops.net [127.0.0.1])
        by mx0f-00379502.gpphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36RFwUUN019438;
        Thu, 27 Jul 2023 09:08:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=llnl.gov; h=from : to : cc :
 subject : date : message-id : content-type : mime-version;
 s=02022021-podllnl; bh=6z2Rm3nZ5k0HT7Mv/2XvZ+ufFaPGDKBEfsy4nHAVb/s=;
 b=uF84OlsYB2sb7fbdDCjpwiObYkw58OZlXzYa0ZuwEEDWfCl7VLGBiV8jwInd5Gu1nd6P
 nLJgK87EddYCIVxebIVQRtbpJoWCmcDufAqEiSHtEZTqeTlYxUxwVfBQfdLK4efGcvo5
 bVAaHrQMAyy9J/hB2Iv0vXfHoytiLDkle2F286rRJWJ2HLIcw9Z836bFkntfoHGerObR
 O/TGlUGRwQ+NPqK00bB7O3LB0SLsBGKXx6qlv1t06FVMfDTVfLhZtAUl8dFaT1HYNdr0
 HGILhEiGsD00vbr6N8Pd78nJ1ggFaXjL5yobnbeBXGCEqL5ILWBuQKih/CWFBWeAWcmZ PA== 
Received: from gcc02-bl0-obe.outbound.protection.outlook.com (mail-bl2gcc02lp2102.outbound.protection.outlook.com [104.47.64.102])
        by mx0f-00379502.gpphosted.com (PPS) with ESMTPS id 3s3beytc1r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Jul 2023 09:08:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aEYkxPNAiTeeObC8fcIhTVl+SFuIwlJaT9t6IHJM+VHqIqbXZ7UMRmA/3P9rm1JxCAWGjqmD4HZB/fmcen/FSt/wSEw91YRNxqo1sWajSQxf9Mqr9WZvv7GgoJUqDDeOoKW2WR7E8bJXpbQpTVbgEFDWvO7EIovYnSOfTk19LmsnAjc7kuLQIM2x94uYNQjYHiI6Bz3kDSZrjgBmO3c9FaJG1auZNsmBjK9TTUDUUaNBNEgHsN4cjgYKoSLj3ENi+62zelIxfX04VYJhphUlLsNxt7tiRBbjmocfLLGeocajUMdmoc5Pu/oqTPHIkDtv9Qk1uWCFNGilxGgh5Fy3mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6z2Rm3nZ5k0HT7Mv/2XvZ+ufFaPGDKBEfsy4nHAVb/s=;
 b=kikdToG8exvqr3qKm0bPbhOMVMz4iXcwN00jH4T3uyy0O8GASUc072/SbWOejN0TeZO5cLKvgO2q4jGbAVS5np4vvgJrhwj2HKawIqNf/YQS8omaejjZaBN+yfWYb3t7fABip37ZY4ioXxuK+jvi8JTF3+2qXfAgVj6/mcdLOhQQRnsbr14GgvxbZDWQGmINNbIhJ74zD4bkKisM8MNDhiLrnJE/MFZVYbKSDhJbhl0uEFd7q19WjyhXMz26kRGFliM7EoN5MGay/aRLCFlkOZe/G7pfrGKTr3hud9GKbVyIvBjO1TFkL8ZD+iefBPOIjETcbm7Qc+2t4dWJcfGbWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=llnl.gov; dmarc=pass action=none header.from=llnl.gov;
 dkim=pass header.d=llnl.gov; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=doellnl.onmicrosoft.com; s=selector1-doellnl-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6z2Rm3nZ5k0HT7Mv/2XvZ+ufFaPGDKBEfsy4nHAVb/s=;
 b=oJCol6w1QYg3bmKHXwAdAMVqav6oqZHVSOWufr9jso25UpbDjpaSYhg6/sVlRUy7hQGK9qzVjque0T7KazRgu1mhJqHaNGhLS9Dm52hHVfzCwbSpjOLaoWK0xiMh9s5voyO/hlfcw4w2/cNlLYS3HPBbO8rtLeqUAcRqSYM8T10=
Received: from BY5PR09MB5009.namprd09.prod.outlook.com (2603:10b6:a03:249::22)
 by PH0PR09MB11182.namprd09.prod.outlook.com (2603:10b6:510:2c8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 16:08:27 +0000
Received: from BY5PR09MB5009.namprd09.prod.outlook.com
 ([fe80::1d54:a809:23b3:1f62]) by BY5PR09MB5009.namprd09.prod.outlook.com
 ([fe80::1d54:a809:23b3:1f62%3]) with mapi id 15.20.6631.026; Thu, 27 Jul 2023
 16:08:27 +0000
From:   "Wartens, Herb" <wartens2@llnl.gov>
To:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
CC:     "steved@redhat.com" <steved@redhat.com>
Subject: Double-Free and Memory Leak Found In libtirpc
Thread-Topic: Double-Free and Memory Leak Found In libtirpc
Thread-Index: AQHZwKSTdEm9viA0bEG6qnpP4TVLKw==
Date:   Thu, 27 Jul 2023 16:08:27 +0000
Message-ID: <E931E05A-A78D-4802-9877-B04E9F610817@llnl.gov>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.600.7)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR09MB5009:EE_|PH0PR09MB11182:EE_
x-ms-office365-filtering-correlation-id: 6da882c9-bdcd-405e-fd5a-08db8ebbb65c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wOf8HFErVSo8UPnp4w7mFFuqy48h9m5dLwdI8H6B9F8y1CraTOQb2Tcey5mcBkGYgdAWYsITEKZuyH1knjPabLxjxBUNjnZbA56pzeiEpLgFgcf/M6bcCivAn6HE8tNkg6YSQNU9mP1pM8umOm6wL8fYO8EoooYSXGy69QoLUWrBA0/OBLLeyBXo24DYGSEhtWbfvhENf0ZCatfGKpP6b+X3przFgvT5ETU2nf8mEs79EWGP0a8F3BHGD2fo3Fi5P6Fs8svcYXKtzEoYR+Ce0qldgEm0dDrLj7T9zV9d3L9tGdX4fBGS2qMuDy1B8vPI116jM2sGXDYbEhXR9K+i00BAygdEM/qKircPvR2T/DoTBoQJ/61ECBaEjATzlPjKOssieNI+Z/0rur3yZe7B+koUin9m05N1kVa01be49ScwWF+OvBAWq90/p9E9SBuvhXiEZetA4T5rlgpmvCS6agVpkjAB+U/TQP9kvUMrX4RIldLOUfjJ9zbssY9dlHkPvgx4NKn2VHP6gaJKdFYAaRskVuux1MCb79Qcim5BcMOSmBAWzP2wE6PxXCYSLIjzAa1KXArxruujKsjk/INkkbfJQiHPAKI2QB52RO1hwFES1krsgpyzgk4lITQxCHNroVSgi1zQJdvmxe6FcMWlGg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR09MB5009.namprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(451199021)(186003)(2616005)(26005)(6506007)(71200400001)(6916009)(83380400001)(4326008)(76116006)(66946007)(8676002)(66446008)(64756008)(66556008)(66476007)(8936002)(5660300002)(6512007)(6486002)(966005)(2906002)(498600001)(82960400001)(38100700002)(122000001)(99936003)(36756003)(33656002)(38070700005)(86362001)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z2tYQVRwQlFSbkl1UlB3VW43Y1c3LzBwM0dBNmxkb3ltOS9sbzZzay94cW90?=
 =?utf-8?B?MUt2UTIzVWlidHUyVmx4T1Z1dkY1TXNhdXlQRXZTU1VNc28zVEdJb1JkYWMy?=
 =?utf-8?B?Q256cFZzdHJDczdCQ1ZmT0VvWlhySHY1MHdtT2hGaTJMcEIwY1ZLNUNuT01B?=
 =?utf-8?B?a2RhOE5PR1J5OFFuVmdyUStOZ0l1MktwbkJSR2xiTU9rdERQYmxGNk5OUDFk?=
 =?utf-8?B?eFFLYU1YQUU2K0NaTC9wRUdpWEo4Ylp0TWZETUtxWG9uLzllWDRFd1R2TGlo?=
 =?utf-8?B?TDVJTzNEKzROcGVacWVkUWUrTS9PZlVZaENqSmVHL0dteFlxRG5JeXRkWTNh?=
 =?utf-8?B?aEptdkNqK1F3RjF2NkxBQXNSRFRuTDFza1lGUnI5eUg3N2lSNldFaDg1SFJh?=
 =?utf-8?B?LzBVT1VzR0srN2lVMzFRK0VJeFRiOVFmMVhQSjk3NEk0TmRQYlpjd3ZsOVFs?=
 =?utf-8?B?enhLT0FvYjEydTh1Z2o1ZEVRdlRmUGR3b21OYWpUemkwT0JRMnRwVkt1b0JH?=
 =?utf-8?B?ZklMejQ4RW1hb2trUDNUSlZzV3BHK2Jma1NJdFlVR2dhMXhtNlUzcHlnSGtJ?=
 =?utf-8?B?TEtzMml6Zm1tV014TE1XUG9WVGRTN25CN3Y5bS8xdkFPbldsaldIY0c1ZUFr?=
 =?utf-8?B?cE1IRmcxSXlBYjBoZ2dMQUhqeHNmN1E3c1NSNE1UeEtuNTNOODZoeVJVVGNC?=
 =?utf-8?B?RHdrQ1YzY1c4YjU3TWVuUi85ZVM4bG9jQWZEaDZ0WHZkUXVrNlhtWExtRXBP?=
 =?utf-8?B?eW9YWDJJeXdnSnJIck5xMWEyQVgrR1NHUmpOTjgxRnI1OTZVM0k1ZUVXZ29D?=
 =?utf-8?B?TjU4dG5yNTFoWGo4VDFEMzlUWDJ4UXRLV2VyMzRTSGJZaTlEbGVtbWQ5anV4?=
 =?utf-8?B?Mk1aS1N3dVBKdTY3YkxqcDRveFF2bm1hN3NlUkhWZVZ3eWtjRmFISW40ak15?=
 =?utf-8?B?dlpZVXNaVU8rYjlIZlozbTVteVl4eVZrc3lZSERmdHAvbUxMRmJnbkRpeVpR?=
 =?utf-8?B?OXBLdXV2TGY3YkVnOGNEUDQ2YkkvT1g4OEJtb3RBQXM1UkxuNjRha3RlbTli?=
 =?utf-8?B?Mi85ZmMzUzQwdnZjTStKb1JMbnpXMjJyb3FScWZjUmhJZWVEa3hVNU05UWRP?=
 =?utf-8?B?Mmx2QlIwVEppcUg4ZFdiYy9lTjFOQkVUS1grQzlRS2Y3N0JnbVljc0ZLUUlL?=
 =?utf-8?B?RXdvd0tpeUw4bEFUeEl2UkFrNU1VLysvOWE2YU8wdmNscEFBSWhYUTVHUm5a?=
 =?utf-8?B?cUl6S2g2TVhlYWFiTlhhZGpWbjVwTGV0T2xIdWFRSVBGQXVqY3l6eEd6RWls?=
 =?utf-8?B?V3dkU1lVQndXS0ppVTJsQXVyanZZa2VMWUswRE9YSTJQYzI3dFozV1AvV0ZF?=
 =?utf-8?B?dmNYZVJ3MjhLV1FuM0tjUFA5VTZZWVA2d2dmbjRwWkQyN25Gb29WdndJdW8w?=
 =?utf-8?B?Y2YxRENDUHRlYytDSnZaV1ZIWjJIZ1k3YUx5a1NPbDJHMHVNelNhcFFUTHRa?=
 =?utf-8?B?OUprSnlZUUNYRWxMdVBVekYzakRVUjhpdE9WbEZSVE4rR2x6ZVZMTEIyV1pT?=
 =?utf-8?B?a1dtWTM2bGU4d3R3NUN3TmQwd2xHK3BSSzJ1TWl2YUtzV3VnWTAyM1Urd1pJ?=
 =?utf-8?B?YjNPTzhrYVUzalUyc3JGWlhuSVRyb3pyUVcyNjk2U2J3SnFkLzNrWFRsT2pq?=
 =?utf-8?B?Qk5FajB5WmtHcVdvdkpQQldCS0hGZ280SjBxZERTZmVCUXJxQnZlekxVdVND?=
 =?utf-8?B?VkZHV3BCQ3BXbENyTXl6M0I5cHFRcEM0bmhic2lYVmhNQXdaOUJwRkJOeWsx?=
 =?utf-8?B?b1Jid2dJd285Zm5ZcjgzNlBncmNjYmlwU0J6Ukc4SzEyTXNMWTBFOHg3clBr?=
 =?utf-8?B?cG12TDEwV1NrTUw5cnVveXBPczZPNUJVWHFoTnlIMWUvWi8raHdIL043VGJ1?=
 =?utf-8?B?MVd4MU0vMHBYa3lCT01jZ1dtMGpYN2FIWHFTam5ob01NSko1Sk92SzRoM3lr?=
 =?utf-8?B?VFVZcWZVaG44K2lPWGNTM0I2SXBUVi9EQW5pWkRRUVlXWHIreTRLcGVjaGgw?=
 =?utf-8?B?a2JLMFdQekJ6OURCU2lBL0t6dkQzNU5LcHVROWsvVkVya0dkV0Q1RE5ualhQ?=
 =?utf-8?Q?/rKQMqzdNZLDK4pQUv71FfqAB?=
Content-Type: multipart/mixed;
        boundary="_003_E931E05AA78D48029877B04E9F610817llnlgov_"
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: P4EwPA7GhZF/iSrSHgfY9Z9PymTxqdgMkhJtc5fxVf0SknERz6SCYFwnlm6XErm5U9ktcX04DXOQhnUJjir4HZQLdCbUm2GmJaXJn0+34Cs3MPTjtCoWVrsHWnOm2Vd+G9TVzb+V4ZLrGUdkiu7OAiTSapXNUanviC87Zw3q5aqVRq3+GLX7gr2yENLQHRQHQqdvTC7TAi4ufVJDtvUNF5K2nFXdIzrX3pfOcmWDY84Fa4yQYzNVxiuiK3zhJWn0eC3KHZPbr1HTd/fbywGqA1o7RgM2eIjDSn+CUV0ppkiUib2l9RnqsvAqT4PKslqIicVd72waAIUtMe8vPlm+QlusyDAjcyACtgoR9b5eEpk9UX3KD/hHrfn9RyfOYYXcsGmIaxp5xTRgHPwUvRXAAsQXQtlKnwBLQN4LcLa4tVjZvcH1hoOdc5JO6+WENDmSNzu0nCSEqGCsim82JT5p3LhPJfgEqhcFLnCesfVQQdu9SjX3FAr3hgm4K0mwfPFP99yLyXcMbNzvvgXK93DIrZESlzK5CdJ9VlApM677M4rVBal1f0fjLFBrqxKCV3mVMn45JUs6oLMCIVjCsfxES5NYJk4cbdp7viGmyx+bw5hAZVIdx7B/IQZPt9+4hQuY545GfBcKGQS74mt6lIV4jbFuVPg0YknLITCbKqyfWxrlLqRXPAUa19GRJ7tD9D9dcwebA04fF/vmDOMDJYQ10x+sHFQbPvoDbet2Z+eVsMhdTOsw++FHmaT665Hzrsz4fN8/8WD7pEk72bmjXfoYd8t+IpXkHQpLUt1yzsfnDehnkjjuT9I5iSz2vmtjjhJJ
X-OriginatorOrg: llnl.gov
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR09MB5009.namprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6da882c9-bdcd-405e-fd5a-08db8ebbb65c
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2023 16:08:27.2536
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a722dec9-ae4e-4ae3-9d75-fd66e2680a63
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR09MB11182
X-Proofpoint-GUID: P1iShIo8KkX1xbRpB4Jx3CvkzppqjFYK
X-Proofpoint-ORIG-GUID: P1iShIo8KkX1xbRpB4Jx3CvkzppqjFYK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-27_07,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 adultscore=0 bulkscore=0 mlxlogscore=741 mlxscore=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0
 malwarescore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307270145
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_GOV_DKIM_AU,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

--_003_E931E05AA78D48029877B04E9F610817llnlgov_
Content-Type: text/plain; charset="utf-8"
Content-ID: <3C04D917B8384D42B20111511876F841@namprd09.prod.outlook.com>
Content-Transfer-Encoding: base64

SGVsbG8gQWxsLA0KV2UgaGF2ZSBvcGVuZWQgdXAgdHdvIHNlcGFyYXRlIFJlZEhhdCBidWdzIGZv
ciB0aGVzZSBpc3N1ZXMuIEkgYWRkZWQgcGF0Y2hlcyB0byB0aG9zZSBidWdzLCBidXQgd2FzIGFz
a2VkIHRvIHNlbmQgdGhlIHBhdGNoZXMgaGVyZSBhcyB3ZWxsIHNpbmNlIHRoZSBwYXRjaGVzIG1p
Z2h0IG5lZWQgdG8gZ28gdXBzdHJlYW0gZmlyc3QuDQoNCiAxKSBodHRwczovL2J1Z3ppbGxhLnJl
ZGhhdC5jb20vc2hvd19idWcuY2dpP2lkPTIyMjQ2NjYNCg0KIFdlIGhhdmUgYW4gYXBwbGljYXRp
b24gY2FsbGVkIEhQU1MgdGhhdCBoZWF2aWx5IHVzZXMgbGlidGlycGMuIFdoZW4gd2UgdXBkYXRl
ZCB0byBSSEVMOC44IG91ciBhcHBsaWNhdGlvbiBzdGFydGVkIGNyYXNoaW5nIGFsbCBvZiBhIHN1
ZGRlbi4gV2UgYmVsaWV2ZSB0aGUgY2hhbmdlIHRoYXQgaW50cm9kdWNlZCB0aGlzIHByb2JsZW0g
d2FzIDIxMTIxMTY6DQoNCjIwMjItMDgtMDMgU3RldmUgRGlja3NvbiBtYWlsdG86c3RldmVkQHJl
ZGhhdC5jb20gMS4xLjQtOA0KLSBycGNiX2NsbnQuYyBhZGQgbWVjaGFuaXNtIHRvIHRyeSB2MiBw
cm90b2NvbCBmaXJzdCAoYnogMjEwNzY1MCkNCi0gTXVsdGl0aHJlYWRlZCBjbGVhbnVwIChieiAy
MTEyMTE2KQ0KDQoyNTIgICAgIGZvciAoY3B0ciA9IGZyb250OyBjcHRyICE9IE5VTEw7IGNwdHIg
PSBjcHRyLT5hY19uZXh0KSB7DQoyNTMgICAgICAgICBpZiAoIW1lbWNtcChjcHRyLT5hY190YWRk
ci0+YnVmLCBhZGRyLT5idWYsIGFkZHItPmxlbikpIHsNCjI1NCAgICAgICAgICAgICAvKiBVbmxp
bmsgZnJvbSBjYWNoZS4gV2UnbGwgZGVzdHJveSBpdCBhZnRlciByZWxlYXNpbmcgdGhlIG11dGV4
LiAqLw0KMjU1ICAgICAgICAgICAgIGlmIChjcHRyLT5hY191YWRkcikNCjI1NiAgICAgICAgICAg
ICAgICAgZnJlZShjcHRyLT5hY191YWRkcik7DQoyNTcgICAgICAgICAgICAgaWYgKHByZXZwdHIp
DQoyNTggICAgICAgICAgICAgICAgIHByZXZwdHItPmFjX25leHQgPSBjcHRyLT5hY19uZXh0Ow0K
MjU5ICAgICAgICAgICAgIGVsc2UNCjI2MCAgICAgICAgICAgICAgICAgZnJvbnQgPSBjcHRyLT5h
Y19uZXh0Ow0KMjYxICAgICAgICAgICAgIGNhY2hlc2l6ZS0tOw0KMjYyICAgICAgICAgICAgIGJy
ZWFrOw0KMjYzICAgICAgICAgfQ0KMjY0ICAgICAgICAgcHJldnB0ciA9IGNwdHI7DQoyNjUgICAg
IH0NCjI2Ng0KMjY3ICAgICBtdXRleF91bmxvY2soJnJwY2JhZGRyX2NhY2hlX2xvY2spOw0KMjY4
ICAgICBkZXN0cm95X2FkZHIoY3B0cik7DQoNCnNvIHdlIGhhdmUgZnJlZSdkIGNwdHItPmFjX3Vh
ZGRyLiBJIGJlbGlldmUgYWZ0ZXIgdGhhdCBmcmVlIHByb2JhYmx5IHNhZmVyIHRvIHNldCBjcHRy
LT5hY191YWRkciB0byBOVUxMLg0KTm90ZSB0aGF0IGRlc3Ryb3lfYWRkcigpIHdpbGwgYWxzbyB0
cnkgdG8gZnJlZSBpdC4NCg0KMikgaHR0cHM6Ly9idWd6aWxsYS5yZWRoYXQuY29tL3Nob3dfYnVn
LmNnaT9pZD0yMjI1MjI2DQoNCldoaWxlIGluc3BlY3RpbmcgdGhlIGNoYW5nZXMgYmV0d2VlbiB0
aGUgdmVyc2lvbnMgb2YgbGlidGlycGMgaW4gcXVlc3Rpb24sIEkgbm90aWNlZCBhIG1lbW9yeSBs
ZWFrIGFzIHdlbGwuDQoNCiAvKg0KKyAqIERlc3Ryb3lzIGEgY2FjaGVkIGFkZHJlc3MgZW50cnkg
c3RydWN0dXJlLg0KKyAqDQorICovDQorc3RhdGljIHZvaWQNCitkZXN0cm95X2FkZHIoYWRkcikN
CisgICAgICAgc3RydWN0IGFkZHJlc3NfY2FjaGUgKmFkZHI7DQorew0KKyAgICAgICBpZiAoYWRk
ciA9PSBOVUxMKQ0KKyAgICAgICAgICAgICAgIHJldHVybjsNCisgICAgICAgaWYoYWRkci0+YWNf
aG9zdCAhPSBOVUxMKQ0KKyAgICAgICAgICAgICAgIGZyZWUoYWRkci0+YWNfaG9zdCk7DQorICAg
ICAgIGlmKGFkZHItPmFjX25ldGlkICE9IE5VTEwpDQorICAgICAgICAgICAgICAgZnJlZShhZGRy
LT5hY19uZXRpZCk7DQorICAgICAgIGlmKGFkZHItPmFjX3VhZGRyICE9IE5VTEwpDQorICAgICAg
ICAgICAgICAgZnJlZShhZGRyLT5hY191YWRkcik7DQorICAgICAgIGlmKGFkZHItPmFjX3RhZGRy
ICE9IE5VTEwpIHsNCisgICAgICAgICAgICAgICBpZihhZGRyLT5hY190YWRkci0+YnVmICE9IE5V
TEwpDQorICAgICAgICAgICAgICAgICAgICAgICBmcmVlKGFkZHItPmFjX3RhZGRyLT5idWYpOw0K
KyAgICAgICB9DQorICAgICAgIGZyZWUoYWRkcik7DQorfQ0KDQogUHJldHR5IGNsZWFyIHRoYXQg
YWRkci0+YWNfdGFkZHIgbmV2ZXIgd2FzIHByb3Blcmx5IGZyZWXigJlkLiBJIGFsc28gdmVyaWZp
ZWQgdGhhdCB3aXRoIHZhbGdyaW5kLg0KDQogSSBhbSBoYXBweSB0byBhZGQgbW9yZSBkZXRhaWws
IGJ1dCBob3BlZnVsbHkgb3RoZXJzIG9uIHRoaXMgbGlzdCBjYW4gYWNjZXNzIHRoZSBidWdzIGlu
IHF1ZXN0aW9uLiBJZiBub3QgbGV0IG1lIGtub3cgYW5kIEkgY2FuIGFkZCBtb3JlIGRldGFpbCBo
ZXJlIGlmIG5lZWRlZC4gVGhhbmtzLg0KDQotSGVyYg0KDQo=

--_003_E931E05AA78D48029877B04E9F610817llnlgov_
Content-Type: application/octet-stream;
	name="libtirpc-1.1.4-LLNL-memleak.patch"
Content-Description: libtirpc-1.1.4-LLNL-memleak.patch
Content-Disposition: attachment; filename="libtirpc-1.1.4-LLNL-memleak.patch";
	size=935; creation-date="Thu, 27 Jul 2023 16:08:27 GMT";
	modification-date="Thu, 27 Jul 2023 16:08:27 GMT"
Content-ID: <A24A7E9E2A420B48ACB3D1E45C9336A2@namprd09.prod.outlook.com>
Content-Transfer-Encoding: base64

LS0tIGxpYnRpcnBjLTEuMS40L3NyYy9ycGNiX2NsbnQub3JpZy5jCTIwMjMtMDctMjQgMTk6MjQ6
NTMuOTA0MTM4MDcwIC0wNTAwDQorKysgbGlidGlycGMtMS4xLjQvc3JjL3JwY2JfY2xudC5jCTIw
MjMtMDctMjQgMTk6MzA6MzQuNDAyODUzMjEzIC0wNTAwDQpAQCAtMTAyLDE5ICsxMDIsMzEgQEAg
c3RhdGljIHZvaWQNCiBkZXN0cm95X2FkZHIoYWRkcikNCiAJc3RydWN0IGFkZHJlc3NfY2FjaGUg
KmFkZHI7DQogew0KLQlpZiAoYWRkciA9PSBOVUxMKQ0KKwlpZiAoYWRkciA9PSBOVUxMKSB7DQog
CQlyZXR1cm47DQotCWlmKGFkZHItPmFjX2hvc3QgIT0gTlVMTCkNCisJfQ0KKwlpZihhZGRyLT5h
Y19ob3N0ICE9IE5VTEwpIHsNCiAJCWZyZWUoYWRkci0+YWNfaG9zdCk7DQotCWlmKGFkZHItPmFj
X25ldGlkICE9IE5VTEwpDQorCQlhZGRyLT5hY19ob3N0ID0gTlVMTDsNCisJfQ0KKwlpZihhZGRy
LT5hY19uZXRpZCAhPSBOVUxMKSB7DQogCQlmcmVlKGFkZHItPmFjX25ldGlkKTsNCi0JaWYoYWRk
ci0+YWNfdWFkZHIgIT0gTlVMTCkNCisJCWFkZHItPmFjX25ldGlkID0gTlVMTDsNCisJfQ0KKwlp
ZihhZGRyLT5hY191YWRkciAhPSBOVUxMKSB7DQogCQlmcmVlKGFkZHItPmFjX3VhZGRyKTsNCisJ
CWFkZHItPmFjX3VhZGRyID0gTlVMTDsNCisJfQ0KIAlpZihhZGRyLT5hY190YWRkciAhPSBOVUxM
KSB7DQotCQlpZihhZGRyLT5hY190YWRkci0+YnVmICE9IE5VTEwpDQorCQlpZihhZGRyLT5hY190
YWRkci0+YnVmICE9IE5VTEwpIHsNCiAJCQlmcmVlKGFkZHItPmFjX3RhZGRyLT5idWYpOw0KKwkJ
CWFkZHItPmFjX3RhZGRyLT5idWYgPSBOVUxMOw0KKwkJfQ0KKwkJZnJlZShhZGRyLT5hY190YWRk
cik7DQorCQlhZGRyLT5hY190YWRkciA9IE5VTEw7DQogCX0NCiAJZnJlZShhZGRyKTsNCisJYWRk
ciA9IE5VTEw7DQogfQ0KIA0KIC8qDQo=

--_003_E931E05AA78D48029877B04E9F610817llnlgov_
Content-Type: application/octet-stream; name="libtirpc-1.1.4-LLNL-crash.patch"
Content-Description: libtirpc-1.1.4-LLNL-crash.patch
Content-Disposition: attachment; filename="libtirpc-1.1.4-LLNL-crash.patch";
	size=703; creation-date="Thu, 27 Jul 2023 16:08:27 GMT";
	modification-date="Thu, 27 Jul 2023 16:08:27 GMT"
Content-ID: <03A0534F4C98264DA471906A4964F105@namprd09.prod.outlook.com>
Content-Transfer-Encoding: base64

LS0tIGxpYnRpcnBjLTEuMS40L3NyYy9ycGNiX2NsbnQub3JpZy5jCTIwMjMtMDctMjQgMTk6MDg6
MjQuOTg3NjEzMjQ0IC0wNTAwDQorKysgbGlidGlycGMtMS4xLjQvc3JjL3JwY2JfY2xudC5jCTIw
MjMtMDctMjQgMTk6MTQ6MzEuMzg2MjMwNTcyIC0wNTAwDQpAQCAtMjY0LDEyICsyNjQsMTYgQEAg
ZGVsZXRlX2NhY2hlKGFkZHIpDQogCWZvciAoY3B0ciA9IGZyb250OyBjcHRyICE9IE5VTEw7IGNw
dHIgPSBjcHRyLT5hY19uZXh0KSB7DQogCQlpZiAoIW1lbWNtcChjcHRyLT5hY190YWRkci0+YnVm
LCBhZGRyLT5idWYsIGFkZHItPmxlbikpIHsNCiAJCQkvKiBVbmxpbmsgZnJvbSBjYWNoZS4gV2Un
bGwgZGVzdHJveSBpdCBhZnRlciByZWxlYXNpbmcgdGhlIG11dGV4LiAqLw0KLQkJCWlmIChjcHRy
LT5hY191YWRkcikNCisJCQlpZiAoY3B0ci0+YWNfdWFkZHIpIHsNCiAJCQkJZnJlZShjcHRyLT5h
Y191YWRkcik7DQotCQkJaWYgKHByZXZwdHIpDQorCQkJCWNwdHItPmFjX3VhZGRyID0gTlVMTDsN
CisgICAgICAgICAgICAgICAgICAgICAgICB9DQorCQkJaWYgKHByZXZwdHIpIHsNCiAJCQkJcHJl
dnB0ci0+YWNfbmV4dCA9IGNwdHItPmFjX25leHQ7DQotCQkJZWxzZQ0KKwkJCX0NCisJCQllbHNl
IHsNCiAJCQkJZnJvbnQgPSBjcHRyLT5hY19uZXh0Ow0KKwkJCX0NCiAJCQljYWNoZXNpemUtLTsN
CiAJCQlicmVhazsNCiAJCX0NCg==

--_003_E931E05AA78D48029877B04E9F610817llnlgov_--

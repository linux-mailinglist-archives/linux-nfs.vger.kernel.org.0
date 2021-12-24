Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FD4547F061
	for <lists+linux-nfs@lfdr.de>; Fri, 24 Dec 2021 18:28:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353302AbhLXR2z (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 24 Dec 2021 12:28:55 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:52610 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229539AbhLXR2z (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 24 Dec 2021 12:28:55 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BOEwoKd012182;
        Fri, 24 Dec 2021 17:28:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=mga4J6bZXbF1RJWxOHHpA6z84vXaewFc77Y+AOCCRNI=;
 b=v1S39nrHxNAED/oY7O4cCnc73f8LrrUIt8SCLYmyNFfNqCecAoM/AhGQrrM22VnHj6fx
 MFarhQk8ZW8lwD+aMLXpcMB5wNK3get8L0C/gs7vgVhl/kno18ZI8aWSY8Ud9vgqaJOq
 iFbTD2DEgKcILCWuLi9nPbP+VSX+odKDnQrKAJkjDwMkofkHryszoGl5eSXL4HE45yNN
 91TGBQk5fPJoeIxgXpCafwjUg64qRLInDc4Ylw/cyEehBIl4YdFbhtoDbqlsS2Kr7ZY1
 8l+IoY/Re4F2xW9K0+1NQs/62B8eMHI1sIojNKnZkeXKQBvahWSSavgaXVrd7Blot3cS bg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3d5fj506u3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Dec 2021 17:28:51 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BOHKdYF014319;
        Fri, 24 Dec 2021 17:28:50 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2108.outbound.protection.outlook.com [104.47.58.108])
        by userp3020.oracle.com with ESMTP id 3d193tdegf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Dec 2021 17:28:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ePJxCoRsXkoIFggzHZQ6wc7hNHewJ4wcnc4XAYdk+k6NTWusaIVWvfquk9noGaAmx5NFW5FSMX2XoTQdS1zpIwajWtfs8tw1cOW/VGldrivKCRP4T/3iO7vUrnwXTONtbA21ZRFIXpGailrbN0ZsODgNW7vOmYxR2AteztKXKs5EWHteaL2HLSix/no5cStu2HPvI8fMj2/PzWmotUYMT/1CiIUztXBsbE2pKOkoGMht4MDM/1W32hO5c/MIIRZ+SqIgEmivnNPTXd3unLW96eENVS5MnRAdvWy+vUKTC0xmZcyMPuWOV0+xLzYuNvqxJbhWNZ8rNcVCXN2UXCDlMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mga4J6bZXbF1RJWxOHHpA6z84vXaewFc77Y+AOCCRNI=;
 b=D8in31pPrxQpPCOJjm3FNMS/2pryHGA4uU4S2JJHGdyzvQc325MmIq+ZbHuqEm/JJKis2DoHgats5PplEqkYmLOHhgFu7bd+WzgTydf3w1+ximkHYwH8D2GlzHIF28+UMEfnlkCTsPyhH4XIZCsDkSUqNh+tDGPL+rATFs2izeXKoZtJ/ThGTAuM5ugs15SeeD5PPr9f1arV5v9eaoXNGlC9USItPu2v5O7vArpgyruQyWF0IYtBlf7/LihC40W0I0QwYh7WjOTE3RM0H2MR3b4oqXqy6XkU8gT7rvKVqJwDruysi2tliZP/CS07VcL1ibUFp7Lr4LfE7TA1W4PvaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mga4J6bZXbF1RJWxOHHpA6z84vXaewFc77Y+AOCCRNI=;
 b=Z+Wz2fTWWnritXvhDwjvKUmpERfbPDmNOLGacfAi3VuMartaeZMfbBxI+lmnFIRMhCiSrQzR9aPF2LxQJIHEekovVp9jayTYL0OycucLlPxTfb9EzZSCEcKP2tBoJmU1IC49EXiw9FLSDn2KKvgLQ1txchtl1IoYkIKYoYXwiTo=
Received: from CH0PR10MB4858.namprd10.prod.outlook.com (2603:10b6:610:cb::17)
 by CH0PR10MB5257.namprd10.prod.outlook.com (2603:10b6:610:df::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.19; Fri, 24 Dec
 2021 17:28:48 +0000
Received: from CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::241e:15fa:e7d8:dea7]) by CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::241e:15fa:e7d8:dea7%6]) with mapi id 15.20.4823.021; Fri, 24 Dec 2021
 17:28:48 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Dorian Taylor <hi@doriantaylor.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: GSSAPI as it relates to NFS
Thread-Topic: GSSAPI as it relates to NFS
Thread-Index: AQHX+ExsNLi86uwBekq6KICGDicKsaxB5tIA
Date:   Fri, 24 Dec 2021 17:28:48 +0000
Message-ID: <48DBBF53-7CE3-4DDA-B697-B14F8C382E78@oracle.com>
References: <234CDB6C-C565-4BB4-AE38-92F4B05AB4BD@doriantaylor.com>
In-Reply-To: <234CDB6C-C565-4BB4-AE38-92F4B05AB4BD@doriantaylor.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 43d3ff29-c269-42c9-c07e-08d9c702d897
x-ms-traffictypediagnostic: CH0PR10MB5257:EE_
x-microsoft-antispam-prvs: <CH0PR10MB52577626BA8CEB111759A467937F9@CH0PR10MB5257.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MEbsH6tyHKYe4+nkFTHMxVRAiVp9ChsaVdXAuJ6/d0Y7T0Jn8IrbKhfq+sRV0F5GNHiigu0dfukfNVjyctEpcd5zsKk4xJqqFiyCzAhxZrLdzJEO5PN3zEp6QxMltNJDTKzbv46bXJQyZHstdTUabHXwih+wlTm4CYL1OplEcHzLp6CsRrXQ9RzMtO16J82pC4TRK82l7xbmfq+yk4wPrEIFDAkvZUpH1BT7dcUS56+8lyC+QBRIZCtcB7n88rDhP/sn93PIJYK+zx3UwbgTQKydJRzy7RtcM6WvInn5LZjmBeA50kfRlCMG5Qtb29ADbXUNR/OarOjajzF+InYOv46FN9Ewb1FhjFeCqo/B+zfg2NmnfvsrFyL+NHeTA649032Qn96s+DhGMTU72IfBw+s8hX4TCiUW65xl4EuToi+J0JI3VoGjIuWIzpcX7k0FfZ6U2nntMtLB07lSE3MZq3oAXzI5d67xP10O+fkE0I8zi4cpF8nPvmmeQMmVTeB/HH95acvf/6FafxUbXxm4tS+fefpC+8g+kmCE99ZAC9RfrKTTvrQEDkARwCBwr6UrS4ydoOK4IA9IiZHJ9QYi1Yz4usne6hdjc6TWRwMEbaKza3hVL3Ehm/FiKisSTpiIzBLsOd2eQ6d7xNmjHKqa2JEafKKWTEnPjhPLVdqsLbZRkF5+RxUK6YuTBZSGMdYaYHiuQEi3MfACb/TORiA/ZWrvStSMnFZF0wWU/8DVcxDEm+jOA6baQXQC/wTUJm9JFrULPERE8RrkmR1hffE+IWfFR7j5d6lpFsHqcbo76OY+FchNgXOdEOik9sUGfPLjYbNqCzy56ubGS1dhqcdSmA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB4858.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(508600001)(36756003)(83380400001)(6486002)(38070700005)(316002)(38100700002)(2906002)(122000001)(6916009)(66476007)(64756008)(66446008)(71200400001)(76116006)(2616005)(8676002)(66556008)(26005)(86362001)(186003)(8936002)(53546011)(6506007)(33656002)(6512007)(66946007)(5660300002)(966005)(4326008)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bWVmZHlrTnlvSHVCendBaUo4Q1JqdDJwMkxyRm84MHB1QmJ6YU9XQVRaQklJ?=
 =?utf-8?B?bXZTbXUxaUFXWTRNdkM4cXl5TkZNMU1LYkw0ZDJmMTJENjBEOXZuR3RkcFFm?=
 =?utf-8?B?V1BBdjRiNTB1ckEwcWN4ZE1mK0ppMmw5NVl4Nk83ZjFUOGp2a2l4ZmRLQndK?=
 =?utf-8?B?YzcrOXdHNGQ1UHh1UXRDb2RNQUc2OHBTU2RPenJ4eXRSanFkVG1OcldvZVVZ?=
 =?utf-8?B?NmVQU250aDJHQmJFNE1qelZUakMvRWhXdzZTSHJmeEhCNUJzbTBFUldyMFJM?=
 =?utf-8?B?U3VKUWJSbUwrK1M5ZGRHK1dqb28zUE1aNjZBcUhHTXFMRm5ZeFd1ZnRyVjlj?=
 =?utf-8?B?SExxL3JKRi9ST3BCRFhYQzErZjdXc2ZZNXVWcmF5VWNIWmFIRDB5dXRla2I2?=
 =?utf-8?B?NzJFZUJvVWFXMUZtWE5CSGV1Y1FWdklrVWVQdkRhUzBlNWFVR1FMTjhiL0t2?=
 =?utf-8?B?c3V5YnI1czhxZGZsalE4end2ZHVaSk5QTXNDRXhOcGlTSDVjUyt3ZU5rNitY?=
 =?utf-8?B?NFFGYUkwZEtGNGhlR2R6MVh6MDVuZEdoclFNYkR5VEFVZzJXMmdjMVBzS2c4?=
 =?utf-8?B?MktwQ3JsVGVHMGFEMjgrY1dVQ2xCNDc2ZFdSRUsyamtFMEpDYnJnSDVBNHFD?=
 =?utf-8?B?cmx4UjFlOFZYR25mMFh0NUVweXpRek9nMTUwSnk3VzI1bFZyNnFzMFJza0RE?=
 =?utf-8?B?QWVyNmhhTFVnVko4M3pWSnhoK0ZtM0tGTHY4VWl0MURaUmVMMSsyeURoK2c1?=
 =?utf-8?B?RTJyVGFtcUFUTndVcDZFSW9mLzNHc2VuWU5SLzdwbWloUFZKUG95TTJzbytE?=
 =?utf-8?B?UEpqdnowd0xsUE5DU2o2VWZiRm5iVDRDQ3BFdFlGMkd4UytONTQ4KzZsdkFW?=
 =?utf-8?B?d1F3cVFFSEZXdTc4R1EyWEZTNmJ3WFp3R1FvTVBZWCt1czA5U01qeUpabXVB?=
 =?utf-8?B?UXh1N2k1dWhlaVJLakVhNlZvN1NoT2hPMmUyZW5rTEZVaTVqa0VsT1VHUXhQ?=
 =?utf-8?B?RVN3cktiM2JqK3B2TjNJRHpaSWREUW0wb09nK0owQXhqV1hFRnFjZjQ2dFpY?=
 =?utf-8?B?Y0tmLzZqRmVzU1dhbWpnNkZkKzdXdHAyT2tPSTU5WTkvaFkvWVRTY2JxUS9W?=
 =?utf-8?B?MjQzL2dpTVRZOW9kR0phdUlNWWltaGxNUXduOFY0Yi94cWxQaytzTVNZK2lC?=
 =?utf-8?B?Y0h0bUYxL29ZTEUyL1VQcTdnQUhTRS9mK29uOW0rb1FrV2Q3YmJodmY5R2pV?=
 =?utf-8?B?SmhROEZCcEhOdEJjSmhSUlBEd0R5WlpDSTQwTWFqQTJnRkhJRVBUTXRkR0xx?=
 =?utf-8?B?L2RkVStaTTluRWlTTGp4M2t0em96Y0R4OWlZcXRHUVIyMnBGN1pqRld2TUF5?=
 =?utf-8?B?TFd4c2tDcHB5cEpZS0licWF1U21NZFpZRW9Ud1BLVmFsQm5QSVJUaEtieHpu?=
 =?utf-8?B?VEsvUDFOOTZzTkozTjVUeklJazU3L0NnQ2J5dm15L2M4QU5iSDVFdlBaOHBq?=
 =?utf-8?B?Yk5YTWxnb1N3UVhRZ1dMZVR4UmJaZXZIa2JVbTdNNTc4TFpjdkxxaU5McnJr?=
 =?utf-8?B?UHNaNlZ6T212RU8ydkJUZ3FPRlQveC9SZUQ3K2JRVUdtOC9uRkxUMklRVVlV?=
 =?utf-8?B?QTFvQ29hcmtJTVhJUHFONWJpOGpubEVmNldtcmtmUEd1Q1FnajE0b0hwekhk?=
 =?utf-8?B?Mi9hTkxaOHo3WDk2QXMrRFNGcmp1N2lacW9vbkpGcG40UWhLNGhubWlqSmh6?=
 =?utf-8?B?MDgrUlJsV3RHaHpUcVFrWWtkQ21rbEpzQ1JRdi9BalVhVFBpOUpCYzZZS2pQ?=
 =?utf-8?B?RW9sMFA0MmVySmNob1d4eEQwVnArQ0VPTUgzaHdncTJKK3ZpMmxGSEk5Sjgv?=
 =?utf-8?B?UjdCQzlJT3VueEtBQnhFbkpsdGNrKzgvQ1A4bWY4eElGT2poUkNPTG1HYVJk?=
 =?utf-8?B?TXFBU1VHWXg1SERCYi96c1dmOXl1M3dCVVQycmt0RFZTc09obGsyVll2azY0?=
 =?utf-8?B?SXhqNWovZGdQOHI5ZkV1b0g3K24rb0oxZ3dRMFJPbmFsZUdqRk9uWkdPdG94?=
 =?utf-8?B?WWk4VUxYbHhFNEFUMXZIU3dncmFTU1VUekl2dUJKWUNOV0ltbU1HMys1Qjd1?=
 =?utf-8?B?TzRkZGc4QmlpN2FuWDV2ckxoV0x0YUhWbzZjOUI0TXJOS0wzNTNSNVFraHJi?=
 =?utf-8?Q?efALwGFXpFA+5R9kdBclzWE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6ECF8787AE90094A89A57944A4A542E3@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB4858.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43d3ff29-c269-42c9-c07e-08d9c702d897
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Dec 2021 17:28:48.6540
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ComULIx1FxssrGrZFmgG8owpX/ad3pijRrlSTr+JqNsfUSCt3peCV29YSYYCv3U4rQm8jWPWTCsO2rOFi+1k1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5257
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10208 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 suspectscore=0 phishscore=0 bulkscore=0 adultscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112240084
X-Proofpoint-GUID: xz1qze7WBbQ2I-ZNGIS95GPF8BSQRBJW
X-Proofpoint-ORIG-GUID: xz1qze7WBbQ2I-ZNGIS95GPF8BSQRBJW
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

DQoNCj4gT24gRGVjIDIzLCAyMDIxLCBhdCA1OjI3IFBNLCBEb3JpYW4gVGF5bG9yIDxoaUBkb3Jp
YW50YXlsb3IuY29tPiB3cm90ZToNCj4gDQo+IEdyZWV0aW5ncyBsaXN0LA0KPiANCj4gSSBoYXZl
IGJlZW4gc2NvdXJpbmcgdGhlIFdlYiAoYW5kIG5mcy11dGlscywga2VybmVsLCBhbmQgbGlibW91
bnQgc291cmNlIHRyZWVzKSBmb3Igc2V2ZXJhbCBkYXlzIG5vdyB0byB0cnkgdG8gdW5kZXJzdGFu
ZCB3aGF0IGhhcHBlbnMgZHVyaW5nIHRoZSBtb3VudCBwcm9jZWR1cmUgd2hlbiB0aGUgKE5GU3Y0
KSBzaGFyZSBpcyBhdXRoZW50aWNhdGVkIGJ5IEdTUyAob3IgcmF0aGVyLCBLZXJiZXJvcykuIFdo
YXQgSSBhbSB0cnlpbmcgdG8gZG8gaXMgbW91bnQgYW4gTkZTIHNoYXJlIGFzIG15c2VsZiAoYSBy
ZWd1bGFyIHVzZXIpIHdpdGggbXkgb3duIEtlcmJlcm9zIGNyZWRlbnRpYWxzLiBXaGF0IEkgYW0g
c2VlaW5nIGlzIGFuIGluc2lzdGVuY2Ugb24gdGhlIHBhcnQgb2Ygc29tZSBwYXJ0IG9mIHRoZSBz
eXN0ZW0gdG8gcG9wdWxhdGUgdGhlICRSUENfUElQRUZTL25mcy8kQ0xJRU5UL2tyYjUgcHNldWRv
LWZpbGUgd2l0aCDigJxtZWNoPWtyYjUgdWlkPTAgc2VydmljZT0qIGVuY3R5cGVzPeKApuKAnSwg
d2hpY2ggdGhlbiBnZXRzIGZlcnJpZWQgb24gdG8gcnBjLmdzc2QsIHdoaWNoIGR1dGlmdWxseSBn
b2VzIGxvb2tpbmcgZm9yIG1hY2hpbmUgY3JlZGVudGlhbHMgdGhhdCBkbyBub3QgZXhpc3QuIElu
c3RlYWQgKGF0IGxlYXN0IGJ5IG15IHJlYWRpbmcgb2YgdGhlIHNvdXJjZSBjb2RlIGZvciB3aGF0
IGtpbmQgb2Ygb3V0Y29tZSBJIHdhbnQpLCB0aGF0IHBzZXVkby1maWxlIHNob3VsZCBzYXkg4oCc
bWVjaD1rcmI1IHVpZD0xMDAwIGVuY3R5cGVzPeKApuKAnSAoaWUgbm8gc2VydmljZT3igKYpIGV0
Yy4gSWYgaXQgc2FpZCB0aGF0IHRoZW4gcnBjLmdzc2Qgd291bGQgKGxpa2VseSkgZG8gdGhlIHJp
Z2h0IHRoaW5nLg0KPiANCj4gTXkgcXVlc3Rpb24gdGhlbjogd2hhdCBpcyBwb3B1bGF0aW5nIHRo
YXQgcHNldWRvLWZpbGUgaW4gdGhlIHJwY19waXBlZnMgZmlsZXN5c3RlbT8gKGFuZCB3aGVuIGlz
IGl0IGRvaW5nIGl0PykgSG93IGNvbWUgaXQgaW5zaXN0cyBvbiBkaXJlY3RpbmcgcnBjLmdzc2Qg
dG8gbG9vayBmb3IgbWFjaGluZSBjcmVkZW50aWFscyBmb3Igcm9vdCBpbnN0ZWFkIG9mIHRoZSB1
aWQgb2YgdGhlIGNhbGxlciAobWUpPyBJIGhhdmUgYmVlbiB1bmFibGUgdG8gbG9jYXRlIGFueSBp
bmZvcm1hdGlvbiBvbiB0aGUgcm9sZSBvZiBycGNfcGlwZWZzIGJleW9uZCBhIGJsdXJiIGluIHRo
ZSBrZXJuZWwgc291cmNlIGNvZGUsIG5vciBoYXZlIEkgYmVlbiBhYmxlIHRvIGxvY2F0ZSBhbnl0
aGluZyB0aGF0IGxvb2tzIHJlbW90ZWx5IGxpa2UgYSBwcm90b2NvbCBkaWFncmFtIGZvciB0aGUg
TkZTdjQoK2dzcy9rcmI1KSBtb3VudGluZyBwcm9jZXNzLCBzbyBJIGd1ZXNzIG15IHF1ZXN0aW9u
IHJlZHVjZXMgdG86IHdoZXJlIGRvIEkgZ28gbG9va2luZyBmb3IgYSBzb2x1dGlvbiB0byB0aGlz
IHByb2JsZW0/DQoNCm1hbiA4IHJwYy5nc3NkDQoNClRoZSAiLW4iIG9wdGlvbiBtaWdodCBiZSBo
ZWxwZnVsLg0KDQoNCj4gKE5vdGUgdGhpcyBpcyBhbGwgcmVjZW50IFVidW50dSwgMjAuMDQgYW5k
IG5ld2VyLCBhbmQgSSBhbHJlYWR5IGhhdmUgTWFjIGNsaWVudHMgY29ubmVjdGluZyB0byB0aGUg
c2VydmVyLiBNb3JlIGNvbnRleHQgYW5kIGRldGFpbHMgaGVyZTogaHR0cHM6Ly9hc2t1YnVudHUu
Y29tL3F1ZXN0aW9ucy8xMzgyNzAyLzIxLTEwLWNsaWVudC1nc3NkLWNhbnQtc2VlbS10by1zZWUt
dXNlci1jcmVkZW50aWFscy1jYWNoZS13aGVuLW1vdW50aW5nLW5mc3Y0KQ0KDQoNCi0tDQpDaHVj
ayBMZXZlcg0KDQoNCg0K

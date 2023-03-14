Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A3996B9D54
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Mar 2023 18:47:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbjCNRrG (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 14 Mar 2023 13:47:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjCNRrF (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 14 Mar 2023 13:47:05 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06CBCB0494
        for <linux-nfs@vger.kernel.org>; Tue, 14 Mar 2023 10:46:51 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32EFONYv012213
        for <linux-nfs@vger.kernel.org>; Tue, 14 Mar 2023 16:19:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=yCkkpd6bgZVc48gKAkrbB02+UQbTqLjSMAQR28HynNs=;
 b=IuxDuGnxdxgf2wzOYh+6ZeSqe/R1bgf4YwcuwKb/s8YYut8T6dlRuPHCehhLnEqMWrDi
 2OtTWV5vWK7Yx6oh6vGFC8xOImwh2gebXSSv15W17r9Iti0ozABhPRbIAQg8NM/ptfRO
 rl8QlFCIYijED8G4rbjSGLDCvM2M5XCrf2Ie9C4pq+JcgAcJRDxPgCHOW7HjswWRrQKg
 tuyXwUn7BE/71UFWGRziJc6OIzwEQuiaHMoqCruHIzqvP5ByxL79ajuzw3Y/PJQcoyKW
 oEOQCmlFQxTXcup8t6R53SCBtXRWhhdcqE+j4e/cgA4s7j+pW9132ujkpBWI2W2GpLWk nw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3p8hhaetxv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-nfs@vger.kernel.org>; Tue, 14 Mar 2023 16:19:36 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32EG1pDG016614
        for <linux-nfs@vger.kernel.org>; Tue, 14 Mar 2023 16:19:35 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2105.outbound.protection.outlook.com [104.47.70.105])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3p8g36vv53-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-nfs@vger.kernel.org>; Tue, 14 Mar 2023 16:19:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WOr9dUhuFefZlAc5g2H+D0i6jrYDo+/Ewj3fvpc1nRe0sWIu+uYtClo1T99ZV4g99IxpDAdvddlw90WkY04RkZM10kelPa9jJ9GyzpP1U91UOXxEO6W409xdw7E2Au13zZu/agcgen/p1Qrq1r7HFDqSZ6O98fnuz/Z8y1eTwFIvFxNX6Pc0NS+GXNdxNGOQi5m6YzYukcvdfai3vh9A2JpvsaIDwN5FHiahHWQvD3m9E14czQVop0Eu4v47BlCisgPJWNcsTKajyIA6qcWPN94wv3eL7wLUmSEGeL3X1wLNw/BoPtvAusInljHrK4dJbm3rB8U+VFqypChyLM/Kcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yCkkpd6bgZVc48gKAkrbB02+UQbTqLjSMAQR28HynNs=;
 b=lZwVwCTT1HgXTr0QkEitMaqD36SM5rKCWyDIQkuVAGn18neZxlxQi0UofFQF2SSviIAc339KMZuoM9SRqQ3Tps9JIreAnkIdNDhcr0TIi6LQjsR3g6m+rDJYO5VtjIZZCmX3mq9TCfYM8e03h6LNR4X3T5riaJMWGSfV7+wyF7PxXutnT98YpWW5letISpZEUMzGnwhu/uVAg/yOBHRgbDwFBsTwi9cfAyUvVW7Mh4O36E1Fn0nSUlw3eP+esJNdvbvXZqkUr4DiYrlGbVZ5XJKoqcu7gu51197p/HZmFLE8KM+Bx1Pt0DgxsRRYmXVzT7Qyx3MXrIRl10CZsQNpRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yCkkpd6bgZVc48gKAkrbB02+UQbTqLjSMAQR28HynNs=;
 b=Dqz71AXYc5c2TkvH4aRSC5BoAfpuC9uF9UU6kUi5f5uOwcPLACeWlvl2D4/RUPqPMEgQcCpo4r6kkVFteYyApmHpBpQXXpuf0dYoqxe9gUKpRMMwd3EE62hPhrJLVtsQX0hO8/sUPSgpQxJcOtNpaQs9XcKSPeODkkAEhBrVnq0=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by BN0PR10MB5096.namprd10.prod.outlook.com (2603:10b6:408:117::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.26; Tue, 14 Mar
 2023 16:19:33 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::82d2:a5f:8f53:813]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::82d2:a5f:8f53:813%5]) with mapi id 15.20.6178.026; Tue, 14 Mar 2023
 16:19:33 +0000
Message-ID: <ed870a33-0809-3cfd-2d5a-b97409568b97@oracle.com>
Date:   Tue, 14 Mar 2023 09:19:30 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [PATCH] SUNRPC: remove the maximum number of retries in
 call_bind_status
From:   dai.ngo@oracle.com
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Helen Chao <helen.chao@oracle.com>
References: <1678301132-24496-1-git-send-email-dai.ngo@oracle.com>
 <9D5A190A-333A-4470-8572-CF85EE9A8086@oracle.com>
 <182842b2-3de4-d64b-d729-f4f6c9c576d6@oracle.com>
Content-Language: en-US
In-Reply-To: <182842b2-3de4-d64b-d729-f4f6c9c576d6@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9P223CA0029.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:806:26::34) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4257:EE_|BN0PR10MB5096:EE_
X-MS-Office365-Filtering-Correlation-Id: a691dd91-b336-404f-53ce-08db24a7e566
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SFDNwlncQLHuR0eFbpGAF1K/XXAydEiPFCraKZexJyH8lUWyGIOQ+ZgiGWK5ZfTHD9vUifYWAVy0uu5obLTZLR+jziTyzaK6ZcPTfadTUEvYEuVZ9XDgGH7XF5lN40gHoJ35iZjZJI9CP6kx0NzMdLzJSoC+2QzE5DQRJ5XsInfKgpr4hcNTIUmliUNEUkxX+78ONKCLc4UkILQEcl2Dj4EATa46smMLeEtICAUgMePojJCrYRx6704MNhSoucXyJrtnN29kA7bvuJg3uVtlfHWmdGOBgDMBsQaBdg1Wt8SWYkkteMC4No/g2CPqoG9UdzaQ9NZTUwQJ7edZgRoSmRj6Vc2zUdYHxbckUNHedeSPaI/gIA4UFuz+Nr7c84W9j4OqyBKnTmsz0ivCrJJhNDY+1fwZe0+VVlS6F+qM263LInm6R9oSix19ncs7rL5KWCIplJKBG+ec+bSvCpYWN3NCQvxrLoV6SVmSt57oAGs+kiLAXPC8yqFiGaM6g0lgAx6ozeHs7Lct26zd6vfwZVYm8bevlvu0eQ5iKlZUVjYsZFw8nGjPBuS+fAbC6Kv3LEd/Q34RNSXJ3lE5meIrlvfbqBO2AWoHv2LCCA8VtfUWmSWIkOTYsg4QcUI3cqWP8/zNZ/f1kvKbnUxczlzLdjUUTFVMGEWBsPzJUUHLkJRd18VH9qWaq6T+tU0+AswuIaFSGjduWrqU2Muyo29naw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(396003)(376002)(136003)(366004)(346002)(451199018)(31696002)(86362001)(36756003)(8936002)(478600001)(6862004)(2906002)(5660300002)(37006003)(54906003)(4326008)(41300700001)(66946007)(66476007)(8676002)(316002)(66556008)(83380400001)(38100700002)(9686003)(186003)(6512007)(6506007)(53546011)(26005)(107886003)(2616005)(6486002)(31686004)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?THluRVBWa3docHpTcnhpSURkb1Fxc3VzSEY4dEYvSmVRZFB6azVaSVoxRkVI?=
 =?utf-8?B?MHNXUGM5VGZacEVrWWxIMXlxU3FkejA3QjVBUS9NeDJxd0ZqcHhidWNaTXhv?=
 =?utf-8?B?RjUydEx4aUd3RHdMNWJ3TUF2NjVlWDJlb1Q1MGJXS2pMQ0Y1MHUvaW0wRHV3?=
 =?utf-8?B?amw5M3A4OGwzK3ZvQ1pBL3BNWUVPNHh0Rk4rYUdvbitocHhnZHdDZ3NqcExi?=
 =?utf-8?B?Z3lkdi9uL0NCekVMTjI0cEJnbGlkVzFXZi9EM2t3TURuQlkvNUxYUm1wUS9F?=
 =?utf-8?B?UmozZ2pHREpJTm5GRzY0SlVrbklldkZYajRUVWF4U0tuYjVaOFpBVjB6Z1pM?=
 =?utf-8?B?eUxkM1hNN2JPRFJuVGFRNHh1eWlDVXU1ODJ3ekM0TUF6MnNOSWFVbjVXWXky?=
 =?utf-8?B?dERVeUZweWpuek1FZWRLRncvd0l5OXRkbVJqbGRDY0M3cnNWOGdaU3hONUl6?=
 =?utf-8?B?bFNkcTlrNEpITEgvU2FqSlVPZHlSYnNhaEp6MWdvVzVBVHJNVTVaTTQxZ3Ew?=
 =?utf-8?B?TXdoZkVzcE56TzcxL1Y5OTFGU2VXdHlPWlBVakhhTU1mb1lBRkVOQUxLcHAv?=
 =?utf-8?B?eWJhcXk1VXh2WklZYW1CMlVjdnhKbUtxL0c3cXFwdGtUdysxYjU2ZDVWUUFi?=
 =?utf-8?B?eVZ3UVVkRnRtRzhubk0vcHRlVFBNWkVGY09tQlhKZzdjaElJWmhRREVpRTUw?=
 =?utf-8?B?MnR4YkNRbU41dDQ5eng3bk5oSGI4RGhaOVVuSk9ieHZReGtBM1E5dGNKTlND?=
 =?utf-8?B?bCtFQWdyZitrbjg4SHhJclV5aFJnTVFXb0dFemlsdnZTSkFtMUVTNmkxOTMy?=
 =?utf-8?B?a1lHZkxXbVcwL0ttMFIvcVI2cHhURlN1V1VDRWxMampQcTVHSzd6WmNlaHJy?=
 =?utf-8?B?d1JuTE5nb2JxZGR2V0VteFpBdEdzR0JlS2pnV3A3ZzRrNWZVcUVhZDN1a3Y5?=
 =?utf-8?B?VTNBcEQ0Rm9jMTRtcXI4dEM5NnEweGZWanJaajRXdHFCUzVPeHBlTDhGS1Ir?=
 =?utf-8?B?NlU1UGc3eElaQlNOdEN3YmJOaU9sdmJ6QTFBMk4rRzBVRUdDQ0VvZFpLeUdG?=
 =?utf-8?B?R2ltSjVqVEd2eHZZRE80WEo4YU9RbXdoZDZLcng4M1U2S1BIMlpFYjh6MTZD?=
 =?utf-8?B?Z0lGVXpiTjI2SXIxRElEMjZMdGdxSnBnb2hMVTVVYkNURHgyR3huVXAyRVp5?=
 =?utf-8?B?V2lmNzBCaUdsLytYVlRKbUNUWDd4UVBWeG1NeWRBd3MwT0xZRjRoTHdFeW9j?=
 =?utf-8?B?Y2g5dVdNZ3VjeFpYSDZsVzVERWhmbFBtbHQxV1ZLUHV5akJqZFJ4T0svNTg4?=
 =?utf-8?B?UitSckRhSUZYVkRQQjF5S05nWkJoS0ZhYW9BVzZGUFU3M2IvU0xZS2NOdy9Q?=
 =?utf-8?B?WjZUTmJ1SWIxdVJrNjBWTTJHN2xOMGRCc0N0ekRUTXlRNWhvYWx6Mllxb1Ux?=
 =?utf-8?B?R0hxaTRvVTRrRVQrMWtpcjJDZ2d5ZlU0cDZtMHZTclRzdzJvMjVFY1ROSkFK?=
 =?utf-8?B?Qit5Y0RKSjByOGRSeDh4aVpoVHhTR0p4R21iYlY1TzBRMWhJZDJ4ZnVobUdP?=
 =?utf-8?B?NWhXcGFvb3VjWDJ1Y2x3b2xHY1Y5elgyVXZCanZlMTZFazZvSFBLL0ZzaVFT?=
 =?utf-8?B?SnBsb1NzZm0zUlVqdVJ2YWEraS95T0s1RDJ3ZWx1UG9Gdk8wY1VVTkFHbCsv?=
 =?utf-8?B?UnFuRWNHenhrUDNuTzdJWmtzeVlFUk9jeHVVRmdGTWNhSTQrUGgzOUZYUUVn?=
 =?utf-8?B?T25NZlRibE53ZXlveTdTVWFSQlNYMmV3YUlmZUUxdEV1ekVUQWVQdXRueEJj?=
 =?utf-8?B?N1ZPKzZUbGN1Mm4vZmp2OXhES2ZsUjhkNFU4WGdvVE9lRWRaWjE1UTIwalZh?=
 =?utf-8?B?S3lkK0FRWUxibTkwYXNaRmpseldFOEwwa1dPV1N0RHlzRlBxK204U01FTTc0?=
 =?utf-8?B?S2cySkJRbklaTEdIYjVpc3ZDZkdjdFU3VHZNN0ZxVmZVaWlLeHFaYVFBV3A4?=
 =?utf-8?B?TXM2cmFlREZXVVpDM0lJU09EYnN5QTRwRGFvME53NWNaTzdCTjlsV0gvT3lI?=
 =?utf-8?B?S2lOMkV5eGZaK1QwS21Pb0lsZ1F1ajZQWXo1eWhhZ2t2QXRFcHlQaSsvV0dI?=
 =?utf-8?Q?3w0hxkvGp1oGNHLLFm3ad1byf?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: klvW6ocCFzz4rUkmgzKFnG1dROwNFs+lBsADRnAvnzDvDDe36okeo+gaAbTGXejvB1whEAzq9xP2wPm49ERJBZP0+Zq28wQKZfTiAJY5/u6xX3zCzEYtYw0fhAbbhn/HnvUxpGi32mjuT6RAJjhcpam9DlKdv1M5+pm0WvL82wVHaGPCTRBA1cLwt2l4cJwZfL2AY+vwQCKKGYws35Ro3w4uLe4S/hStMTg6dgObEEJrP5AWZENniKHdh7arivC6Xemt7GuGftPwinODO8hWDPlDpRqusWSUp2nPcfnDTkO24oBw44bCVkLTNglT/bBOX0eeeDXBjiLXzd/7PP0VppgHxuHI3cidxzvpBEiI0ORrxrGx4AD2a5Tb9ior9P/ttefwcvEqIBoEG8Dt99y4iZCm0GtkdtUxYNxHHODHfQjBDT74Em8mnVPYvC1BMAHaKRFmQqoFKr+R3r8I88u0ToaTd0bge+oLh68qiVYiAdhMitv8VbSrL5LBZzUASv2OvSXQlQ55b4Ep5v1RtnzySFlXxYC+UcIQ+LiNbGSwaECu8SkAu+AgEZLUKr+uJgxU+xJkCn/iV15+kaLJ/ytdwK7Rm7x4JZAsDsTsJM2N+IQLLH1wWDgt9obAeJDrPrQZu3O3IMYdzfmUvYmzqZ+agXtPz+pX3JVT2hNEnW2CRgUK9K/twehd07KBVb3LyUzj6J3QclfMVC7vC/ZLpEqeiRZcF9OwkSKzTIqItqr2O0Y/itl9yWz+LA9sKQPnZGsq+XKs2N9LJehJwbZ14FGPAg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a691dd91-b336-404f-53ce-08db24a7e566
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2023 16:19:33.1914
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pQVfcUYk/hO482iyFhk1fmrTHL+p7QtjY13jOSVtpbr24NZBLdB1g7VkOiiRySSINEDE7g4Vbi+9bTeRW1ADiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5096
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-14_10,2023-03-14_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 phishscore=0
 spamscore=0 suspectscore=0 malwarescore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303140135
X-Proofpoint-GUID: p8vGdwkcAKCj1qdagZgYFC9g508Mivma
X-Proofpoint-ORIG-GUID: p8vGdwkcAKCj1qdagZgYFC9g508Mivma
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


On 3/8/23 11:03 AM, dai.ngo@oracle.com wrote:
> On 3/8/23 10:50 AM, Chuck Lever III wrote:
>>
>>> On Mar 8, 2023, at 1:45 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>>>
>>> Currently call_bind_status places a hard limit of 3 to the number of
>>> retries on EACCES error. This limit was done to accommodate the 
>>> behavior
>>> of a buggy server that keeps returning garbage when the NLM daemon is
>>> killed on the NFS server. However this change causes problem for other
>>> servers that take a little longer than 9 seconds for the port mapper to
>>> become ready when the NFS server is restarted.
>>>
>>> This patch removes this hard coded limit and let the RPC handles
>>> the retry according to whether the export is soft or hard mounted.
>>>
>>> To avoid the hang with buggy server, the client can use soft mount for
>>> the export.
>>>
>>> Fixes: 0b760113a3a1 ("NLM: Don't hang forever on NLM unlock requests")
>>> Reported-by: Helen Chao <helen.chao@oracle.com>
>>> Tested-by: Helen Chao <helen.chao@oracle.com>
>>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>> Helen is the royal queen of ^C  ;-)
>>
>> Did you try ^C on a mount while it waits for a rebind?
>
> She uses a test script that restarts the NFS server while NLM lock test
> is running. The failure is random, sometimes it fails and sometimes it
> passes depending on when the LOCK/UNLOCK requests come in so I think
> it's hard to time it to do the ^C, but I will ask.

We did the test with ^C and here is what we found.

For synchronous RPC task the signal was delivered to the RPC task and
the task exit with -ERESTARTSYS from __rpc_execute as expected.

For asynchronous RPC task the process that invokes the RPC task to send
the request detected the signal in rpc_wait_for_completion_task and exits
with -ERESTARTSYS. However the async RPC was allowed to continue to run
to completion. So if the async RPC task was retrying an operation and
the NFS server was down, it will retry forever if this is a hard mount
or until the NFS server comes back up.

The question for the list is should we propagate the signal to the async
task via rpc_signal_task to stop its execution or just leave it alone as is.

-Dai

>
> Thanks,
> -Dai
>
>>
>>
>>> ---
>>> include/linux/sunrpc/sched.h | 3 +--
>>> net/sunrpc/clnt.c            | 3 ---
>>> net/sunrpc/sched.c           | 1 -
>>> 3 files changed, 1 insertion(+), 6 deletions(-)
>>>
>>> diff --git a/include/linux/sunrpc/sched.h 
>>> b/include/linux/sunrpc/sched.h
>>> index b8ca3ecaf8d7..8ada7dc802d3 100644
>>> --- a/include/linux/sunrpc/sched.h
>>> +++ b/include/linux/sunrpc/sched.h
>>> @@ -90,8 +90,7 @@ struct rpc_task {
>>> #endif
>>>     unsigned char        tk_priority : 2,/* Task priority */
>>>                 tk_garb_retry : 2,
>>> -                tk_cred_retry : 2,
>>> -                tk_rebind_retry : 2;
>>> +                tk_cred_retry : 2;
>>> };
>>>
>>> typedef void            (*rpc_action)(struct rpc_task *);
>>> diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
>>> index 0b0b9f1eed46..63b438d8564b 100644
>>> --- a/net/sunrpc/clnt.c
>>> +++ b/net/sunrpc/clnt.c
>>> @@ -2050,9 +2050,6 @@ call_bind_status(struct rpc_task *task)
>>>             status = -EOPNOTSUPP;
>>>             break;
>>>         }
>>> -        if (task->tk_rebind_retry == 0)
>>> -            break;
>>> -        task->tk_rebind_retry--;
>>>         rpc_delay(task, 3*HZ);
>>>         goto retry_timeout;
>>>     case -ENOBUFS:
>>> diff --git a/net/sunrpc/sched.c b/net/sunrpc/sched.c
>>> index be587a308e05..c8321de341ee 100644
>>> --- a/net/sunrpc/sched.c
>>> +++ b/net/sunrpc/sched.c
>>> @@ -817,7 +817,6 @@ rpc_init_task_statistics(struct rpc_task *task)
>>>     /* Initialize retry counters */
>>>     task->tk_garb_retry = 2;
>>>     task->tk_cred_retry = 2;
>>> -    task->tk_rebind_retry = 2;
>>>
>>>     /* starting timestamp */
>>>     task->tk_start = ktime_get();
>>> -- 
>>> 2.9.5
>>>
>> -- 
>> Chuck Lever
>>
>>

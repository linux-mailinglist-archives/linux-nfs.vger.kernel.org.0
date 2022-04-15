Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E423C502C2E
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Apr 2022 16:56:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353034AbiDOO6m (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 15 Apr 2022 10:58:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348301AbiDOO6l (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 15 Apr 2022 10:58:41 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F1C2EA9
        for <linux-nfs@vger.kernel.org>; Fri, 15 Apr 2022 07:56:12 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23FD9k98018418;
        Fri, 15 Apr 2022 14:56:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=sN+nfzVszLBfo2yi+eAp+iCNw11O6ExD5bwJRFMxFD4=;
 b=fNRd0nD3ZNaRmTGvwTpgEycsy+UDr+R8BegKwImdAclxXmIWiQVUOjSdxO8ZEeBDeEcZ
 njqeSBfurSH5rHmAbm4yePBuTbDfBf2yZ/IIVvGQTRaKi3L9KzDWRTgZX6j9J9f+8of7
 Lr5M2/1TgWzupbhk1WFsSQmDKhwoDrknmmrSu8e25DdhCUHbMxeLuXgA9/xZii+fCihf
 8fXIkyT0mQ6MvqQ+wHZLjxvB+b3i61AVa/Uxeg14DIhLwKhTNCyjAyHsPkXFFhEGbqES
 mOg1Jcwl7yOhrmWzKu3uSD0pboXsgAIosh4T9CcX/oTtkE3sUUgHxP0LdAOUrX7TOPWn Mw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com with ESMTP id 3fb0r1qcux-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Apr 2022 14:56:10 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23FEqRbi033008;
        Fri, 15 Apr 2022 14:56:10 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2177.outbound.protection.outlook.com [104.47.58.177])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fb0k68hep-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Apr 2022 14:56:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aw0dK6k6fQUzeec31GeP5XoPfcCVtXa4yBDtRlaT4O2Nn8s4cn2MdLjsIfmsEawWM0WM9p8C+dR3e6DndOMdCU9TAfWAfToA7xextTpBMfvMDR38PbhLOjidv1g6eG+bmpJmiDUc/kQBqz5qXm3VEnf1KrYOCls82TOuj1YzuYksG85J1XLmj3FhoAdP2t+CZ5chgJM6oEj3tH+uPv3atGOnTkxojIct11fb87PKiWk2wx/q5fXKJdgWIinRd+b1ZyB3Op8MPbDxFZqbbPG1hXmtjIq+9YgXWYL5Og0itVa2vyyxtSmp1QMvi7La04xv+DBEU6WAT1FeRJX5eBAeOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sN+nfzVszLBfo2yi+eAp+iCNw11O6ExD5bwJRFMxFD4=;
 b=be5e1ulF4Bj38f4mW6jooaKONodiFCR30KopaazwMZPzuxh+cbjgVV24e0brqUw5nJCc8RiJcuHeCPgzHbFe5mC1ZHQnInmYn8NJibTF26WTBgza2vwaeiktJMDcaJu2mOKcR/DL/bzgCgYGsDVaSwF+2H+HE0fjFFUKZG8jucHqabcUOLKA/eiLFOeyRgiAnx+RNWilKqZ+ItZ7MvlTWbR1r5q64WnGD5yVcVLd3duhn/3EWCIhyxPHTiW0Ygj3HMtLW9uco6lRqXy4z4uFSniML1be+8qiymNQl26ArHMtl/Xc9bNBweEnUMxKO9f9EWjoAlxVQaiA7cj0C+JsuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sN+nfzVszLBfo2yi+eAp+iCNw11O6ExD5bwJRFMxFD4=;
 b=ho3YaHUAS3MSO+U8bDJs3ZkJGc/PilF8t6zaIkoY2G0x8DG+CPEeOPVRcELczx/vo5HlYf4QUdqcokJPo+jFxlqs2AYanCdBWtGS4kgzKMW2vHqMN6F0gMefw9xXSBM7NLHtGl/uTDKm8OOdukZq7HdAidJHpKDcMdEcH85wpeQ=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by BN6PR10MB1553.namprd10.prod.outlook.com (2603:10b6:404:47::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Fri, 15 Apr
 2022 14:56:07 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::52b:f017:38d1:fd14]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::52b:f017:38d1:fd14%2]) with mapi id 15.20.5164.020; Fri, 15 Apr 2022
 14:56:07 +0000
Message-ID: <eaf758e8-077d-f7fe-1e02-cfaa49830d97@oracle.com>
Date:   Fri, 15 Apr 2022 07:56:06 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.0
Subject: Re: [PATCH RFC v19 06/11] NFSD: Update find_clp_in_name_tree() to
 handle courtesy client
Content-Language: en-US
From:   dai.ngo@oracle.com
To:     Bruce Fields <bfields@fieldses.org>
Cc:     Chuck Lever III <chuck.lever@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <1648742529-28551-1-git-send-email-dai.ngo@oracle.com>
 <1648742529-28551-7-git-send-email-dai.ngo@oracle.com>
 <20220401152109.GB18534@fieldses.org>
 <52CA1DBC-A0E2-4C1C-96DF-3E6114CDDFFD@oracle.com>
 <8dc762fc-dac8-b323-d0bc-4dbeada8c279@oracle.com>
 <20220413125550.GA29176@fieldses.org>
 <fae06919-13de-9ebb-8259-108f6e18c801@oracle.com>
In-Reply-To: <fae06919-13de-9ebb-8259-108f6e18c801@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0101.namprd03.prod.outlook.com
 (2603:10b6:a03:333::16) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a4af548f-0e53-4547-f37e-08da1ef0126b
X-MS-TrafficTypeDiagnostic: BN6PR10MB1553:EE_
X-Microsoft-Antispam-PRVS: <BN6PR10MB15530CB329D6F708D4828E4F87EE9@BN6PR10MB1553.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Jvg3F2MKq8PMFifqn+ySHI9DB2uxHnoNf1C1uYB55KRtrxOou2j6/rYpOrF/teTCtXz1aV3yrceea0oBbc7wvpq2Qc4yiMmIGHSkDN8CIhQ4prOEFnkBfK+xkpdd/ihf4QoOoExCVQbSyog4dNKy4qTY0qMCYQ7T5YvWsqyl5hMyRG7ckBMlEuZTJeXYFZB8m5YHaKLQxP/VnWbqWVu5EX1S4tpf83EsgzWE+CaInPg5qy/WSYhKAG/A/FmGhgw1gxSQ9RF1GZLRWsmqhPnSNVrIr7wl6ceEdItS/7zL+fITdObe1Kt1HriORFvpZbxbraJMr1GnW3RTowSqg9MIx7Mp5fCqMmUPj0A0zFdob2JtYf0zWIIfHHpdv0FS8/MY0kCQBnxgBf5+P2c/6vicSaKbz+8bgavEoYN6mR/iiKcBRsv+FMuiMjUUofSQWmOatWK35npN55lDByB1w9lwHPqB/gcC5bImN9wGcZA3s94DdV4La+BhBO1oSI39yWRhHjwctW+FCuZhOjaHVLf/2o0ohuCbVQ3hpU5ldGVa+rkrQefhP2TG3PuCmD4YrTWA1+maq3cQklfQp5m6PxGTEBzxU4OFDr2KeiuW450anmmSH10aO8aj2UF6Z8/ERI9vzudG29W39KIjlpi6eHKhH7Pnj0DWpW+48wOnrLVc3NANTl/TBhL+D7QhpkUZOwV59zSaBJzSBRGLACpwqZVMNw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(5660300002)(6506007)(66556008)(8676002)(186003)(36756003)(83380400001)(2616005)(2906002)(8936002)(6512007)(9686003)(53546011)(38100700002)(66476007)(26005)(66946007)(15650500001)(4326008)(86362001)(31686004)(316002)(31696002)(6916009)(54906003)(508600001)(6486002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?anlHVEZIdmVaREg2RTFCd3FCa2p1Y1lhOUhaTklkSXp2YjVUbjI0dzBWNWtm?=
 =?utf-8?B?am8rKzVtOFZmMEdFa1pBV0hRY2s4Yms1dWw3RHh1bmc4U2orVlFmcDRIZFpW?=
 =?utf-8?B?RGhOMjNxbm5maiswTmVrWUVQdlVyZDJDNi9FUTVUZkVJV2kyZnRBMGU1ZkUz?=
 =?utf-8?B?S05GdGtKRVVhYWE0bTcvSXBkZHpIU09KR0Nab2pxSXVhRW85eUczUXRqajVx?=
 =?utf-8?B?YUx3ZWVWZTBTaFpzMU84c1BuZDNRVzQyTWRBUFgvSXllMUdxZ2x2Z2dPeGNS?=
 =?utf-8?B?MUJBYWxwcEpyNTNXcVBhMlFhZHFobEVRWFlBOEYzaTMzTXFZSlVJYjdNUU9M?=
 =?utf-8?B?V3FGL1Q1dXVhYUFPQW5zR2kzZHE5RFpSRWdvY2sraHlFSFVFMy9DQXlXUUQ3?=
 =?utf-8?B?VUlFN1JUY05QNzdWd2NTTmNDVUxYRHlock9WZG93a2RZYm5mcWNGbURQL2hl?=
 =?utf-8?B?TXBLRUVxL0p4T0daYUk4SWlOWEt3RUFYUUxPTytodnFEcSszL2FqekZvOHlO?=
 =?utf-8?B?dCtGSHVjM0N6TUppRUlsTDhuVVlZMUd1cjlEKzJxeVFVYUozTUJCczQzcldx?=
 =?utf-8?B?T05qaUNXcStCREpqNzhnS2FxVThldDBoblpld1pjUERHbVhCWDd4RkdBNEtH?=
 =?utf-8?B?RHpzbUFXVHJxcWhSNlFJdE5vV0JpNGFNZkdSK2lCMFRlTVJqSG5WT3NTUnRW?=
 =?utf-8?B?aVNzcC90RThnay9STjA2VEswN0dMQnBhYTZsYTRNNFFCTDBOSmswWTV6citS?=
 =?utf-8?B?bkNDM3B1bjVuWmZRWHBZWlBhSkxNMDVNNm56V1BtNmRBb3JMbTBUcUVuRUxu?=
 =?utf-8?B?TDloalh5c01vR3B6VmtQa3d1bU8wQmtSM3BXU1E1Q0p3VENuUGZTR3NwNXhV?=
 =?utf-8?B?LzBUVW55eTBhNzBSWDUrRzYwS004UDJOT2VRUFE1b2FvcE1PSldiQSs1Z0U4?=
 =?utf-8?B?UzF1N0F0WVRGN2Z3bDY3TTJiS3d6am0yUkhLS0NucVFTQnJKbVJVeXE1M3l6?=
 =?utf-8?B?Q0FBLy96ZFdKbHBtZkZsUGZaalNSRnlvZTVoRkFncC9IZG5uTUpGckpMT2xH?=
 =?utf-8?B?V1BMaTYwSTVSRElTQ1hsVXpFK3JmRDRFMTR4Y0JQalZMNWJFMGd5akpVeEVC?=
 =?utf-8?B?NWFselFaSWZESVc1Z1lzd2dnUFBZTGxkSmk3QWJuckwzMWl3Z1ArYjFleTdV?=
 =?utf-8?B?MWtvMWVMd3ZBSkEzWXd2c0xmbXNTSGdscXJncXlYL3JCa0ZTY054aVJuby8w?=
 =?utf-8?B?TU9CSFRSTzE0Wk1PQzJyNmlHTjhuYk9Cczl1bGJQV1JoZDlZRTdJaEtZVGJw?=
 =?utf-8?B?R1J0SXo2ZnVUWWs5N3ZONUw3YTRKdnJuZnNod05BUkpjOVovZ0d1aGwrekFp?=
 =?utf-8?B?VWpGN1NIUGMwNDRVVVBjNTZreko0bkI4REJ2dkUyMEErVFZHR2tRRDIxcDAw?=
 =?utf-8?B?ckR6K2J3SmhLeWZvT2VJTmhNQTRUK2lYMFJrT0RMckFxTC92UUFLQ28rZVdU?=
 =?utf-8?B?Nk1FV2s4a3FqdC9NYytWekdXUEtZaVVpbzZYMjJCMGYxbjgydkJYUXdETjNR?=
 =?utf-8?B?eHBQVWZLbUdUaTlHNDFEM3FJV3lGWW5NRjZWU2pJaittbUd6WFhpcERYc09l?=
 =?utf-8?B?ZEhXWkpvbENDcmdyL1Y5czlHd3JDeE5zaTJZZkhBVDcraitveWtRdi9GRU5C?=
 =?utf-8?B?VUdKR1Z3R0lqQjlQaUZZeTIzd0k1N2w5N3E4V1k1OTNiazBLalp1VUZnQnlG?=
 =?utf-8?B?Q0RSUGZHVmVBaGJEWmNvZnJhU1J5QTU2RmlyZWRrQ0lHa0tPZk5vSGRrcVJQ?=
 =?utf-8?B?ajM0WWRYMjZ5czJNd2h4UWhEREthMHpwbkpOQ2RLOFVEcUFBOFlQb2Y0WGV6?=
 =?utf-8?B?eXpuZjJsN3ZsdVhoK1pjWUVXZkd1VjZjTVBDRFZuTGJBQnlPak1aT2ovb0tQ?=
 =?utf-8?B?RzlNeldFSDQxWmhaSTJQVWlyR2IzYUpKMy9Md1pKSGl5QVdoTVRMY0I4MzQ0?=
 =?utf-8?B?VjErT2Fsbmpma0ROTE5icnJUL1hSeUgwM1dpTDJWOXZBQmhKelhlMTUrNFp4?=
 =?utf-8?B?R2hzOHRRZ0JLaDA0WE82TWRsWVZkQlBRVlNvS1c2Ym1sS1ZBbFlSRDJ0dWQz?=
 =?utf-8?B?dkNPdTZVMmNTZ1N6OW5hR1cvc0RaRnd0K0VwMFByL0NHNjR3RFZXcXVzR2Jn?=
 =?utf-8?B?Q0g0SFBoU0FJd2VkekNqd2UrMXUvbW43Qk9OaGNwSXVwNXhmZDhaTGIvRlY3?=
 =?utf-8?B?RENiUm5sMXBRUXRTaTFWMyt1QktJVktmaU5pZVNHb2x5ZmM5ZTVndklsOWox?=
 =?utf-8?B?YXZBdUs0ZTdoVmFnSXcwZnc5cjc2YWFuODBrVUREbXJOanZyM2FZQT09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4af548f-0e53-4547-f37e-08da1ef0126b
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2022 14:56:07.7176
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YEGhIfphyth4qHNA55loEx9d5pSrtfFMof+rplVe6tubiZJNTextGZud80AKsh5SIrTrpa7NTxzbe/KiPy8p4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR10MB1553
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-15_01:2022-04-14,2022-04-15 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 phishscore=0 suspectscore=0 spamscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204150088
X-Proofpoint-GUID: lkMwQIsbtb1xTPy1I6AYavnhVAIn48rZ
X-Proofpoint-ORIG-GUID: lkMwQIsbtb1xTPy1I6AYavnhVAIn48rZ
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


On 4/15/22 7:47 AM, dai.ngo@oracle.com wrote:
>
> On 4/13/22 5:55 AM, Bruce Fields wrote:
>> On Fri, Apr 01, 2022 at 12:11:34PM -0700, dai.ngo@oracle.com wrote:
>>> On 4/1/22 8:57 AM, Chuck Lever III wrote:
>>>>> (And to be honest I'd still prefer the original approach where we 
>>>>> expire
>>>>> clients from the posix locking code and then retry.  It handles an
>>>>> additional case (the one where reboot happens after a long network
>>>>> partition), and I don't think it requires adding these new client
>>>>> states....)
>>>> The locking of the earlier approach was unworkable.
>>>>
>>>> But, I'm happy to consider that again if you can come up with a way
>>>> of handling it properly and simply.
>>> I will wait for feedback from Bruce before sending v20 with the
>>> above change.
>> OK, I'd like to tweak the design in that direction.
>>
>> I'd like to handle the case where the network goes down for a while, and
>> the server gets power-cycled before the network comes back up. I think
>> that could easily happen.  There's no reason clients couldn't reclaim
>> all their state in that case.  We should let them.
>>
>> To handle that case, we have to delay removing the client's stable
>> storage record until there's a lock conflict.  That means code that
>> checks for conflicts must be able to sleep.
>>
>> In each case (opens, locks, delegations), conflicts are first detected
>> while holding a spinlock.  So we need to unlock before waiting, and then
>> retry if necessary.
>>
>> We decided instead to remove the stable-storage record when first
>> converting a client to a courtesy client--then we can handle a conflict
>> by just setting a flag on the client that indicates it should no longer
>> be used, no need to drop any locks.
>>
>> That leaves the client in a state where it's still on a bunch of global
>> data structures, but has to be treated as if it no longer exists.  That
>> turns out to require more special handling than expected. You've shown
>> admirable persistance in handling those cases, but I'm still not
>> completely convinced this is correct.
>>
>> We could avoid that complication, and also solve the
>> server-reboot-during-network-partition problem, if we went back to the
>> first plan and allowed ourselves to sleep at the time we detect a
>> conflict.  I don't think it's that complicated.
>>
>> We end up using a lot of the same logic regardless, so don't throw away
>> the existing patches.
>>
>> My basic plan is:
>>
>> Keep the client state, but with only three values: ACTIVE, COURTESY, and
>> EXPIRABLE.
>>
>> ACTIVE is the initial state, which we return to whenever we renew.  The
>> laundromat sets COURTESY whenever a client isn't renewed for a lease
>> period.  When we run into a conflict with a lock held by a client, we
>> call
>>
>>    static bool try_to_expire_client(struct nfs4_client *clp)
>>    {
>>     return COURTESY == cmpxchg(clp->cl_state, COURTESY, EXPIRABLE);
>>    }
>>
>> If it returns true, that tells us the client was a courtesy client.  We
>> then call queue_work(laundry_wq, &nn->laundromat_work) to tell the
>> laundromat to actually expire the client.  Then if needed we can drop
>> locks, wait for the laundromat to do the work with
>> flush_workqueue(laundry_wq), and retry.
>>
>> All the EXPIRABLE state does is tell the laundromat to expire this
>> client.  It does *not* prevent the client from being renewed and
>> acquiring new locks--if that happens before the laundromat gets to the
>> client, that's fine, we let it return to ACTIVE state and if someone
>> retries the conflicing lock they'll just get a denial.
>>
>> Here's a suggested a rough patch ordering.  If you want to go above and
>> beyond, I also suggest some tests that should pass after each step:
>>
>>
>> PATCH 1
>> -------
>>
>> Implement courtesy behavior *only* for clients that have
>> delegations, but no actual opens or locks:
>
> we can do a close(2) so that the only remaining state is the
> delegation state. However this causes problem for doing exactly
> what you want in patch 1.
>
>>
>> Define new cl_state field with values ACTIVE, COURTESY, and EXPIRABLE.
>> Set to ACTIVE on renewal.  Modify the laundromat so that instead of
>> expiring any client that's too old, it first checks if a client has
>> state consisting only of unconflicted delegations, and, if so, it sets
>> COURTESY.
>>
>> Define try_to_expire_client as above.  In nfsd_break_deleg_cb, call
>> try_to_expire_client and queue_work.  (But also continue scheduling the
>> recall as we do in the current code, there's no harm to that.)
>>
>> Modify the laundromat to try to expire old clients with EXPIRED set.
>>
>> TESTS:
>>     - Establish a client, open a file, get a delegation, close the
>>       file, wait 2 lease periods, verify that you can still use the
>>       delegation.
>
> From user space, how do we force the client to use the delegation
> state to read the file *after* doing a close(2)?

I guess we can write new pynfs test to do this, but I'd like to avoid
it if possible.

-Dai
  

>
> In my testing, once the read delegation is granted the Linux client
> uses the delegation state to read the file. So the test can do open(2),
> read some (more(1)), wait for 2 lease periods and read again and
> make sure it works as expected.
>
> Can we leave the open state remain valid for this patch but do not
> support share reservation conflict yet until Patch 2?
>
> -Dai
>
>>     - Establish a client, open a file, get a delegation, close the
>>       file, wait 2 lease periods, establish a second client, request
>>       a conflicting open, verify that the open succeeds and that the
>>       first client is no longer able to use its delegation.
>>
>>
>> PATCH 2
>> -------
>>
>> Extend courtesy client behavior to clients that have opens or
>> delegations, but no locks:
>>
>> Modify the laundromat to set COURTESY on old clients with state
>> consisting only of opens or unconflicted delegations.
>>
>> Add in nfs4_resolve_deny_conflicts_locked and friends as in your patch
>> "Update nfs4_get_vfs_file()...", but in the case of a conflict, call
>> try_to_expire_client and queue_work(), then modify e.g.
>> nfs4_get_vfs_file to flush_workqueue() and then retry after unlocking
>> fi_lock.
>>
>> TESTS:
>>     - establish a client, open a file, wait 2 lease periods, verify
>>       that you can still use the open stateid.
>>     - establish a client, open a file, wait 2 lease periods,
>>       establish a second client, request an open with a share mode
>>       conflicting with the first open, verify that the open succeeds
>>       and that first client is no longer able to use its open.
>>
>> PATCH 3
>> -------
>>
>> Minor tweak to prevent the laundromat from being freed out from
>> under a thread processing a conflicting lock:
>>
>> Create and destroy the laundromat workqueue in init_nfsd/exit_nfsd
>> instead of where it's done currently.
>>
>> (That makes the laundromat's lifetime longer than strictly necessary.
>> We could do better with a little more work; I think this is OK for now.)
>>
>> TESTS:
>>     - just rerun any regression tests; this patch shouldn't change
>>       behavior.
>>
>> PATCH 4
>> -------
>>
>> Extend courtesy client behavior to any client with state, including
>> locks:
>>
>> Modify the laundromat to set COURTESY on any old client with state.
>>
>> Add two new lock manager callbacks:
>>
>>     void * (*lm_lock_expirable)(struct file_lock *);
>>     bool (*lm_expire_lock)(void *);
>>
>> If lm_lock_expirable() is called and returns non-NULL, posix_lock_inode
>> should drop flc_lock, call lm_expire_lock() with the value returned from
>> lm_lock_expirable, and then restart the loop over flc_posix from the
>> beginning.
>>
>> For now, nfsd's lm_lock_expirable will basically just be
>>
>>     if (try_to_expire_client()) {
>>         queue_work()
>>         return get_net();
>>     }
>>     return NULL;
>>
>> and lm_expire_lock will:
>>
>>     flush_workqueue()
>>     put_net()
>>
>> One more subtlety: the moment we drop the flc_lock, it's possible
>> another task could race in and free it.  Worse, the nfsd module could be
>> removed entirely--so nfsd's lm_expire_lock code could disappear out from
>> under us.  To prevent this, I think we need to add a struct module
>> *owner field to struct lock_manager_operations, and use it like:
>>
>>     owner = fl->fl_lmops->owner;
>>     __get_module(owner);
>>     expire_lock = fl->fl_lmops->lm_expire_lock;
>>     spin_unlock(&ctx->flc_lock);
>>     expire_lock(...);
>>     module_put(owner);
>>
>> Maybe there's some simpler way, but I don't see it.
>>
>> TESTS:
>>     - retest courtesy client behavior using file locks this time.
>>
>> -- 
>>
>> That's the basic idea.  I think it should work--though I may have
>> overlooked something.
>>
>> This has us flush the laundromat workqueue while holding mutexes in a
>> couple cases.  We could avoid that with a little more work, I think.
>> But those mutexes should only be associated with the client requesting a
>> new open/lock, and such a client shouldn't be touched by the laundromat,
>> so I think we're OK.
>>
>> It'd also be helpful to update the info file with courtesy client
>> information, as you do in your current patches.
>>
>> Does this make sense?
>>
>> --b.

Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB90F66477B
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Jan 2023 18:33:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233597AbjAJRdf (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 10 Jan 2023 12:33:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234554AbjAJRda (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 10 Jan 2023 12:33:30 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51D5B48831
        for <linux-nfs@vger.kernel.org>; Tue, 10 Jan 2023 09:33:29 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30AHT4Tn031292;
        Tue, 10 Jan 2023 17:33:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=Zd2HzH854Hx6zW0XX49bqhfZ4AgtrDDjPukMoBvHSAk=;
 b=18Fgj7WG6LpWbUyjy9WM/chf6ecDEKSukHCvISZ2FCq8jUoxH/+zNSSoNB6uih87EbuQ
 7MC3Nc1o7nSdPN9jfm6DZRb/j5aRCqWKXku0r1VYFNNtiWd9g6zm3JtTv8PAMv4Qs1XG
 qkAd4V8pXp8rDh3Ap9X7fRhATtrHpFGquuPH6fFCzIHoV4wTK7mnFOtyy1d1L9nKCHJu
 C4ttIebGR4BRQ6XFlysTKWZhTG46TI7lOQUWPplytBHlEH2NlZDEGkcYy/Pb55GxHuUO
 IbMdLl0xuVPKfXOVbWF1atksUnYcaesROaft5hMy93DpjDD8+Gp1vpnIdvjNnfMjVcpK mw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n1cbq80vs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Jan 2023 17:33:22 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30AGXqpb030459;
        Tue, 10 Jan 2023 17:33:19 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3n1bnab54d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Jan 2023 17:33:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SS8VIQGuTftv+a7D8d1B5GgJ56QMSZ2uGJCUGzXPqmdWdft9PtErFs6FLwCTLE4GMap6E9EhchBIb/SU/08Ww57uUXqFS3wTlkZO1J0SEG1NgJWB5fVTOfS3oPcQNYSHoclQdzcVJL3wbdhcGZd71LGjud7pSON+yV0KN/PB4MIJcdRKeQz1FLmqzg8xcN/DenqKX5966UCiSWyucvXHDXzBe466cz8CYu7aS7y/j+rRDyhModIcuvB2HahM0IWqfb8pqd50Kgrf5W4BKrBcOsQskq1/43wow78HpKpweO+VF8UFfmj1M7rkcrmp6zreLW7R+uXJUgWCNFa0f5JJcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zd2HzH854Hx6zW0XX49bqhfZ4AgtrDDjPukMoBvHSAk=;
 b=b3BKsu/46IFCdbKusyH+q0Y3yPzwiWQB59SAxYus0MDJ5kQ0k6T9qpA62q8FUYfqTKKII2HOYSusaSPLKgSpScmPJNs3wsB/moO0f+TG3KOoyKoQOhIequJHPP2IdRc1JXwAyRdDD96XXpGxLrfxLjFtM22z28QIbnSbnevCgdKh6UtciV03W+vqihEzaBXmfLRrXcAbX/Z6iLSurKj7NEmlwqL4VxC9AO/zwEpC+OgfAJlcmyUyoJhudHB4ZW91jH4d+M3JZAvKdh8Ic8jlIUjHpz/twi7zzeAjyFJcfWA0OBrcSP48YroChtPWDrB9e/AKZxv4s42VLGi1r1zzTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zd2HzH854Hx6zW0XX49bqhfZ4AgtrDDjPukMoBvHSAk=;
 b=WFrzpxVNiUdP6iGtsDBQyYL6juac9MCoQ0Y+SLCT9OxVVl/psGRUF+6kqIvdk3DxymIbWsOovv1L/mCLoj4cbcZ5sxMBzlbhuMhecbpm6gZ4th4CgPv6MSaDcAe0gw+SgarThPgWgIPRLnHwtSAxJCJHah+d+QYEZmQeYi9YVfA=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by PH8PR10MB6622.namprd10.prod.outlook.com (2603:10b6:510:222::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Tue, 10 Jan
 2023 17:33:17 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::940c:19a:12c5:e152]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::940c:19a:12c5:e152%7]) with mapi id 15.20.6002.012; Tue, 10 Jan 2023
 17:33:17 +0000
Message-ID: <71672c07-5e53-31e6-14b1-e067fd56df57@oracle.com>
Date:   Tue, 10 Jan 2023 09:33:14 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH 1/1] NFSD: fix WARN_ON_ONCE in __queue_delayed_work
Content-Language: en-US
To:     Jeff Layton <jlayton@kernel.org>, chuck.lever@oracle.com
Cc:     efault@gmx.de, linux-nfs@vger.kernel.org
References: <1673333310-24837-1-git-send-email-dai.ngo@oracle.com>
 <57dc06d57b4b643b4bf04daf28acca202c9f7a85.camel@kernel.org>
From:   dai.ngo@oracle.com
In-Reply-To: <57dc06d57b4b643b4bf04daf28acca202c9f7a85.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0166.namprd13.prod.outlook.com
 (2603:10b6:806:28::21) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4257:EE_|PH8PR10MB6622:EE_
X-MS-Office365-Filtering-Correlation-Id: 2de0cb42-ed52-4d52-0efa-08daf330c274
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SawIbYFMz5JeeIbVXNCZjkRMR6h5PWg8eVaM1rWjs4ftGqZKFoH4GOaLtsjOTNT2TSnh7oY5cLAwvlTlorT1hZWMvSbnJlLHASi9mx5nz//63xUdgWoRPMhZ74l+HvB0m4wWgDqShmLE4WoCT3hBaoTlXfck6CuVpGWDio6nRs1OCYR9qAfAmtM/V7YJMDMLWFYYbSbcVwECTl27frxee6CUVbrfG7ayaHs+uWU35lecrYLkC0YHpewzjxZq8tLrzUIM2qaEJ/UPBZ7dw2orVqV6CGHQoImQ7NKHkq6aLaCnf0eI9STjBAA90oPmMBJMHLotjW+22Mt3QhJW6Z6tyPd0e2AfZgrspVmqBvoOMp+hoX5eUMQNKOuV8BImIHTK8X6NwbeU+wrRQzBq+VcJDz6Wv9OCv9ApRGrtBa88NkoQZA3mJp37sq007x9f9ymtDzTuYi2D0O7wLcYvqV8GF1YcKbPugGSZq70dDezMUvoXjuyVT1botTmMaEpj0PnD/ULYEPJggxGy8cXFOkZzY/Ngd24C1ZVD2fJbQ5G9jvldwL7qDUk7J6U8OHVrZwCffDOhozYfwkXEgzG+ohwcHvYycuBXXrM2ptqgUOTFvOdkRGlPFxQ9XeDXsfyTYi0TL2qZjl0fpFduoHmdE/QRY6WwC/Gc9taMDePbLkQbpq8mvUw+PtiXFNyifom2A6rtm0F5QhXPgCrqcX34TVKkaQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(346002)(366004)(376002)(396003)(136003)(451199015)(9686003)(26005)(186003)(5660300002)(6512007)(6486002)(478600001)(66476007)(66556008)(66946007)(4326008)(2616005)(316002)(8676002)(83380400001)(36756003)(8936002)(41300700001)(31696002)(6506007)(86362001)(31686004)(53546011)(38100700002)(2906002)(6666004)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MW5PU052THZDVzlGelkwYTRXN0dSUGNXZGMyR0x1NmZtVTBvbVh3T1NsWnFG?=
 =?utf-8?B?TzdkbkNzbTgxenpRUXR3QVJmTU80Tzd1bUg0STd2Unh5dTNzbUN4SEd3U283?=
 =?utf-8?B?NWdXUWh1Wm11TEtFRFVveS9yZGpuMXFCUUpQSlFKQ09iUWh4UGw1UUdRSE9E?=
 =?utf-8?B?VTdCNGtjb2tzOW1GUFdHS1F4SE5JbTdrTHJQZ21wUVN1RU5oaEpmaDBoVkU0?=
 =?utf-8?B?MUpmdUx4NVRrZDJEc2NOMjd1MTNlS1dCd2dNVHh3ME9Bdis3ZVdxd2k2MG9E?=
 =?utf-8?B?OWtLaWtmUllUUFBEaTlqSW0zanZEcE1EcnFHN0NtMm40bCtjSjV6UlNQL2tm?=
 =?utf-8?B?U3BGM1pLZFVUMmJIVFNjR0h4c0crYlFDQjViMlBXN29QT0hDK0tsR1pUbzV6?=
 =?utf-8?B?cmZkbE1FbWZ3Vi9HOE1FQkdwV0dkVmVLK2VxWFBzTFR5UEt4blRDV29aMlZa?=
 =?utf-8?B?alBMNkZXak0wQXpaUlBzaWNUMUxaQ0VVdEt3YzZLblJLNDZKUlpyTW0wMU9E?=
 =?utf-8?B?QlpjWW1wSkpyUXZlNk02V3FoOWVXbzNtUEpEZnFWdnlYMENHV0dPQ1BtdkpW?=
 =?utf-8?B?eFYyMXRNTTB2SFpicEJFY3FJZXprVmRpVEJmL29uellWWVlEUW8rYmlQVUFw?=
 =?utf-8?B?ZWxtUkRlNnI1RzA4T3dGVm1TbkRqcVVpTVA1MXU3a2R3a1M4TUx4eVE0b2x4?=
 =?utf-8?B?YWdZOE5taUpxOU1tc2szRi9pVzVoVTltUlpERldlN2NTL3BYbkc2Q0VaU0hI?=
 =?utf-8?B?TVQ3dE9OZkhteTNOeWZEOVBsTi9wNDh5OE9MdGRiMk54dzRnSFFLWkdTdTA0?=
 =?utf-8?B?TVFITFAyYTJLOUpwSm5KVnZBMXFON2lUR2dqQjRGdWhEMXA2c1pWQWNLWjdz?=
 =?utf-8?B?MUNZMUhuTnVkT3R2Z3IxYS9kNFFGN2xRRk5oaW9iclhmWXNnSkJ0NklOYm5u?=
 =?utf-8?B?ZEtEVkgvaU1oRVJiS1grUTUwOE5kQlpUVDdFNVhZb245akZKTlplVFQyaGF2?=
 =?utf-8?B?bGtnZytyK0wwM0I2TnBMZThqVUdlR2paZmI2RnNtSnhLdWVwaEoxd3MydDdO?=
 =?utf-8?B?d1RidmtLT1c3TjJTMkY5WHdHSWZjcWRDU2lTYW4yZTE2WGFDcWl5NVJxeFRx?=
 =?utf-8?B?SXhPWGtNQ29SeG5WYkxGNktxS1JQRVFpZEVTaWt0UHA3VlJpd2hVRVg3REs1?=
 =?utf-8?B?SmRJUXd2L2NtNEk4Q05BQ3huc0lFbVBoOUtiQWJtaEtzY1VUT0FoQ01velNo?=
 =?utf-8?B?eTArNS9lajJST0hmS29ScDA4NUNnWGVyTGo3VXpqTnJHR3h6R2RhSDhTRUc2?=
 =?utf-8?B?UzVqQjdvK1h2VVl0WnlvaFVwQWxTd21NOXdoblh2bS9Fc3J6cExWTTBMUHl4?=
 =?utf-8?B?TnMrVEh2N3JGTHdDcnFVNE9sejRZM0NNdEJ1RWpCVEJsS0lER2xyRmVXcHZX?=
 =?utf-8?B?MmN6RFArU2RHQkZNbHJaZjBtR1VGSkRsUzNLbmJOcE1IcktlL1pTL0FaK0p1?=
 =?utf-8?B?UXhtdXpNcE1MRTNnN2RuSVFqK2RzV21GQ0IzOWloNjdSaDlaRVFjb2VyY1VB?=
 =?utf-8?B?R3JTTTFJMGFhWDYzVGJRblFlV1lZcE1aRlJzbzBQV2Y4N1pjZnRYdUYwY29P?=
 =?utf-8?B?dk1xd0dyTnhydGd1ZmJCVVZVN05TYXhLS0o0R0ZIYk5oUERaWDlOLzNnaHpm?=
 =?utf-8?B?QkxuUzFpTVd2L1ozc3R3U0VwbXlSL1kvb0grV0pwUXE2VmFQbzIremJRYWcv?=
 =?utf-8?B?Y2h5WElVcmRDN01kZW41VGVDYkE5c21nSmpZeHVVVExsdjR1UHJ2dGRsT0FQ?=
 =?utf-8?B?Y3pmRjdKQTZaRExVMDU0aisyY2x2c0x2ZXNSNlB0cEQ2U2x2NGpzWWtidjRU?=
 =?utf-8?B?cThUNFdlUHE1TGVjRHMyR0lia0pLT3RUM2tRUVVJdzZUR2V6emh1MFpRSUoy?=
 =?utf-8?B?akNWNUtuSlJFc2JWUGlxVWFSY0J3YkxiT1ExUms2bGlnUHdaQ2tsWTFYYmRG?=
 =?utf-8?B?THdDUzkrSGNDcW9EQ3huSUlyYmZDSHNaSlJqSWhqVG5LdWhjWVhDdVY2N0hO?=
 =?utf-8?B?emJCTERmWk04TkFvbERFZ0FCU0JGaS9BVTNxb28rTzdDWnBzOUkzNWhKTEUx?=
 =?utf-8?Q?+MCMGMnb9JXkVcn1OclduMJYm?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 0O/1FxgWy+HIZ8l6C+ZAub4cUbZfa75Bjyi523Uf/F2DdyOXas1FrN3AwU3PVcNQjrPwr6KwpwFCyS+g00bBrDEQ+zT+nR9JfvFMnlWTqIutdvR0dgAnniCrEVLcyq/vks2Tl/Dlnei7glTdjVsFP9NLylUvOa5kCcE8By46mOmNeuPHerIcrrQ/Yy8NNOAWa1XsC39FLhStOkTbMl92B6DLJ7h8+6ow3TZwxBLjlVAtJ+E3KvTUMFsF/wW8N9Jw5yZ/OXGuJBTiAovlATxRO8oCwjdIEQmjmgRezdHEg5puyszM9j7M0PZ7j57zKSczg9/9YmOpA6BH8kGl/ZzTjJ7uhiLHftVHUlVmRv0xp8PA1u3tHzwepv1IqV866tB6TWUKpFnDR4QGfai7Ual67qCDZsWAqzPoA8ANaC2nvdF76WeyvlIrEfnHYXJURMgk//7Zy8UiISIK0yY+UDtC+T43OrzPcHlkUBpeG+frZjTlseUEqGIVmWLiLqmoQ2n2agcCt8pxCLSXfnWIhS8EY0lEvMxFN+O0oO2d/83G058PwCwwUNLpg4Ju2B7k88aUAZZhUSZPmJzOdRfddiEnK9ysOEjYoy3IaO/S5MZIvr84Qf0vxNpd03vcse7U0MaAWimej1fg2Okbum+xZqWSlvOLyP/P52DJci0OlikutnvvsxQng302G2LlkAPykVheWBXTPb/0iBZ0o7m5EZXIZgDpTTv5n/htFQr4iUSpo/XVUxIiWCaOCUxcITYvkOOdLaF8crN/ytf9JTGD3yJ0nzLH1rckF9ACWP8EVcd1jch6fQHzCXoFr6gx0/MXCgXS
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2de0cb42-ed52-4d52-0efa-08daf330c274
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2023 17:33:17.4118
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YC9Mw7fP8xlAwF0va5qLmNqZN9sPUpcWM67skjIdTTayrUkaAwVQm0rzodG4P83+NmEevnJpQD+eN7aWf+kzWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6622
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-10_07,2023-01-10_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 malwarescore=0
 adultscore=0 mlxlogscore=999 spamscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301100112
X-Proofpoint-ORIG-GUID: Znr8-dzaplZT7X7LVKwKHBB7YkeKlncP
X-Proofpoint-GUID: Znr8-dzaplZT7X7LVKwKHBB7YkeKlncP
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


On 1/10/23 2:30 AM, Jeff Layton wrote:
> On Mon, 2023-01-09 at 22:48 -0800, Dai Ngo wrote:
>> Currently nfsd4_state_shrinker_worker can be schduled multiple times
>> from nfsd4_state_shrinker_count when memory is low. This causes
>> the WARN_ON_ONCE in __queue_delayed_work to trigger.
>>
>> This patch allows only one instance of nfsd4_state_shrinker_worker
>> at a time using the nfsd_shrinker_active flag, protected by the
>> client_lock.
>>
>> Replace mod_delayed_work with queue_delayed_work since we
>> don't expect to modify the delay of any pending work.
>>
>> Fixes: 44df6f439a17 ("NFSD: add delegation reaper to react to low memory condition")
>> Reported-by: Mike Galbraith <efault@gmx.de>
>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>> ---
>>   fs/nfsd/netns.h     |  1 +
>>   fs/nfsd/nfs4state.c | 16 ++++++++++++++--
>>   2 files changed, 15 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
>> index 8c854ba3285b..801d70926442 100644
>> --- a/fs/nfsd/netns.h
>> +++ b/fs/nfsd/netns.h
>> @@ -196,6 +196,7 @@ struct nfsd_net {
>>   	atomic_t		nfsd_courtesy_clients;
>>   	struct shrinker		nfsd_client_shrinker;
>>   	struct delayed_work	nfsd_shrinker_work;
>> +	bool			nfsd_shrinker_active;
>>   };
>>   
>>   /* Simple check to find out if a given net was properly initialized */
>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>> index ee56c9466304..e00551af6a11 100644
>> --- a/fs/nfsd/nfs4state.c
>> +++ b/fs/nfsd/nfs4state.c
>> @@ -4407,11 +4407,20 @@ nfsd4_state_shrinker_count(struct shrinker *shrink, struct shrink_control *sc)
>>   	struct nfsd_net *nn = container_of(shrink,
>>   			struct nfsd_net, nfsd_client_shrinker);
>>   
>> +	spin_lock(&nn->client_lock);
>> +	if (nn->nfsd_shrinker_active) {
>> +		spin_unlock(&nn->client_lock);
>> +		return 0;
>> +	}
> Is this extra machinery really necessary? The bool and spinlock don't
> seem to be needed. Typically there is no issue with calling
> queued_delayed_work when the work is already queued. It just returns
> false in that case without doing anything.

When there are multiple calls to mod_delayed_work/queue_delayed_work
we hit the WARN_ON_ONCE's in __queue_delayed_work and __queue_work if
the work is queued but not execute yet.

This problem was reported by Mike. I initially tried with only the
bool but that was not enough that was why the spinlock was added.
Mike verified that the patch fixed the problem.

-Dai

>
>>   	count = atomic_read(&nn->nfsd_courtesy_clients);
>>   	if (!count)
>>   		count = atomic_long_read(&num_delegations);
>> -	if (count)
>> -		mod_delayed_work(laundry_wq, &nn->nfsd_shrinker_work, 0);
>> +	if (count) {
>> +		nn->nfsd_shrinker_active = true;
>> +		spin_unlock(&nn->client_lock);
>> +		queue_delayed_work(laundry_wq, &nn->nfsd_shrinker_work, 0);
>> +	} else
>> +		spin_unlock(&nn->client_lock);
>>   	return (unsigned long)count;
>>   }
>>   
>> @@ -6239,6 +6248,9 @@ nfsd4_state_shrinker_worker(struct work_struct *work)
>>   
>>   	courtesy_client_reaper(nn);
>>   	deleg_reaper(nn);
>> +	spin_lock(&nn->client_lock);
>> +	nn->nfsd_shrinker_active = 0;
>> +	spin_unlock(&nn->client_lock);
>>   }
>>   
>>   static inline __be32 nfs4_check_fh(struct svc_fh *fhp, struct nfs4_stid *stp)

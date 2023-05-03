Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F6916F569A
	for <lists+linux-nfs@lfdr.de>; Wed,  3 May 2023 12:54:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbjECKx6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 3 May 2023 06:53:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjECKx5 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 3 May 2023 06:53:57 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A192349DE
        for <linux-nfs@vger.kernel.org>; Wed,  3 May 2023 03:53:55 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3436PNkq029059;
        Wed, 3 May 2023 10:53:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=D5SICncNmEtoG+qIkRslDLhY49DquM8jy/+L6tnFcq4=;
 b=v6f1guaRmzgWAvZLsZd94gABbE0syz/7Yq5NYnClA9IHEdSrRBp/IciZKz4876Wg+1O+
 Z2WNyqKJiwWnHuXzj+IyahVpUh7u0rlGX5zTL7o3Y8C1SGF0Yqvz+f/oszzm9S0OWiDd
 pkjVpGQ0VF3XnYmgFg1vLuB3vmLDd7QU3Amum1BOYNhgqhQFJ350awrD1PtMlZ/ruiHe
 mNbbZI4V4j6OYwYO1zvgMK1G1pD1yZtM769ci/X16y8rBlzWVR6oRpvpUcjDi+GWVG5B
 gwNWeVRKVBVS37qdU0XBgDoZ+NF8qeunG1x2JYbjf1HNFBACvft4hry0DGdr4j2j57c/ SQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q8u9cy2r4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 May 2023 10:53:51 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 343ABHd8010002;
        Wed, 3 May 2023 10:53:50 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3q8sp7fh17-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 May 2023 10:53:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TQvhtHNZb+zj2T0d7boKc33z4UUJVYcJv2GZF6yJZr2FOgzHc2ueUX8+qFh5/Vh4L4r1JvVzfwQpoE7H8mG8/mt+/BMg7bxNcZ0GTbwNFkfYZ0qUAr3B7aHA4V/5z4LnyaUXMetpQ59GSzjSVCyKepFQuVizuf33OEwhizJqVpIeo7fCNXUoKF80NBXC0dnCCrc9+Beb6QKFaMNvNBeI89cbpAFMMTWNkKwilzH8FcqeEJthdytMoI6bmnxP5PhCOkzJ2s9hnrwz+golcLIDtQuqB4g1sikYkYWcvAORBAT7CL/bCqcTEj4zIBObj3bYxOEFYvwSIlPQCtW4axfvDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D5SICncNmEtoG+qIkRslDLhY49DquM8jy/+L6tnFcq4=;
 b=UvPrlh88r2CTLpqo4aYdqIlTzddtYuVWvJYLIvdNNbLil0s7OY6YkTcQ4cCShfUXsDRKDdS/4nDJLeIQm0L688G6zfqG61MTAmeanym3iObBKjCavx7hMeIqjsUcFTMycvULnxaBgmFozJhHD8CKyvAbyw44nLFE0FwmKe3lsBMNx6dKaBFfz8nqHxEKt06/OlbhJWsiDI+/LVEYORNi4nPdzWG5AspzVPlMNidWoUQyA0t75vamtvHil+NRsB7UgafQmICDRf6BaJy0nkJ7fTFEzseH8hm2aCXz7k6FFsw0jg6skBAcseNjRmITQZYAs9DUYHtBkdVBL+0GfQn4Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D5SICncNmEtoG+qIkRslDLhY49DquM8jy/+L6tnFcq4=;
 b=WNQry4CH9QjM4sTlOZK7CVjbBTz3h6hRS4YSJ7iEHmTR2sATg5uY0ctyqM4+ZV/hyrxJ2pn9XEiWz8YJLbOzKSc3wHQNwcUH0pYmz350BMsTmq2n3b8NZAsle13ch0k+9lTe68rlmslPtG5JXchgrxjpvHMmdJBXn34iNMP+Osk=
Received: from PH8PR10MB6290.namprd10.prod.outlook.com (2603:10b6:510:1c1::7)
 by SN7PR10MB6956.namprd10.prod.outlook.com (2603:10b6:806:34a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.30; Wed, 3 May
 2023 10:53:48 +0000
Received: from PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::68c5:330c:d234:3834]) by PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::68c5:330c:d234:3834%7]) with mapi id 15.20.6363.022; Wed, 3 May 2023
 10:53:48 +0000
Message-ID: <ac5c9882-8cc7-8d64-5784-fd71b04dde3a@oracle.com>
Date:   Wed, 3 May 2023 16:23:38 +0530
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.1
Subject: Re: [PATCH] nfsd: use vfs setgid helper
Content-Language: en-US
To:     Christian Brauner <brauner@kernel.org>,
        Chuck Lever III <chuck.lever@oracle.com>
Cc:     Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Sherry Yang <sherry.yang@oracle.com>,
        Darren Kenny <darren.kenny@oracle.com>
References: <20230502-agenda-regeln-04d2573bd0fd@brauner>
 <77C7061E-2316-4C73-89E5-7C8CA0AEB6FD@oracle.com>
 <51805A56-F815-405F-8CDF-4CD04A17436C@oracle.com>
 <741D94D5-4058-452E-830B-49D3BEBD5D8E@oracle.com>
 <20230503-mehrverbrauch-spargel-258668d27f53@brauner>
From:   Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <20230503-mehrverbrauch-spargel-258668d27f53@brauner>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYWPR01CA0047.jpnprd01.prod.outlook.com
 (2603:1096:400:17f::12) To PH8PR10MB6290.namprd10.prod.outlook.com
 (2603:10b6:510:1c1::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6290:EE_|SN7PR10MB6956:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a022dab-51a8-4167-c41b-08db4bc4ac79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Gc9/nc16ZthVnTRnQc0RYzK5ixiRd3c0u5KUI3YFJggN7y655bREgLnkUoftn5WkeInRzNGyMlidk7Y5K94kmIRg+/K0OkdO4B9ze1EpL+S6uuwP7q0xfcm/AkfkcM+MaLN4jyXuJR801yh8qQXAYnJJLMaTj0FuGYa5ZebXBXRTedGmd1Etm8uhgOg4KYKsPvl4ETSL7q61ZI5qkQR+X/W3G9J7A+tgA3bWo6CI6TrzPEie60+wqqU65XjuHpXyBphanhDfSoLY5rFtCB6lzJ4XWUEPZuxU7lUw1pUKHKH5W8AGEzqxW3Q/TrlAcaB8iI5iroDZt343Vwb2kJCiQRoLeU2JEv12ti2AZrbrR1kF3CuUvXAWaDnEXWOmHWvNq/7zItKWojQqxS44ibmR43v3pTsL80zrHV092T2FaHJRoDHbXnkqIWFYQytQOEb97ctucp1zut/9wCXUs+VdjCS8fQNhT4h/xh3VYmAk71d/8H6jwl0/sXBgs28YKQbPJez/6AZ9bpz4YT/hR6wAo5p45MNzimBQN4Ntw9OW7QxcmCTxdFM0exF6xHvFXcy5Jr9y8MpA5G8hrkValgeFn/HZJg4eOXN0sAXvAC8YJhr3ZdkLLtFujPpx3IDbxtf1IykZ9pycWf3YQpExsGfjeA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(366004)(376002)(39860400002)(396003)(451199021)(31686004)(53546011)(6512007)(4326008)(6506007)(316002)(2616005)(38100700002)(8936002)(8676002)(31696002)(86362001)(5660300002)(54906003)(110136005)(478600001)(83380400001)(26005)(41300700001)(2906002)(36756003)(107886003)(6636002)(6486002)(66946007)(66476007)(6666004)(66556008)(186003)(966005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NDNEZU4zMjY4bFFybko3L05wQ2ZKVHhrZDJZWmV6cWR1WUtyTlkrcUpIRUti?=
 =?utf-8?B?V24rNUFCckRMTzdldkJSbnRqRWI2SWZFQUVXZHlXUmYwWHpBa21nTTNCOVRt?=
 =?utf-8?B?c1pjWVZORTdueCtadzNqU3NQVisrNS9sKzFHdytVMk9tN3U0TnBKTDRJUlY0?=
 =?utf-8?B?RzF2aTZ4ZTdYMFVxZ2pyMkZkT2F5UUN5L0xVQWVCV0VtemlHYVhMMXRibmZS?=
 =?utf-8?B?WVpBQlRaTTZ0SWlkUjZTeUM2M0tJQ1VXQ1dNU1N5NjYyYlg2Q3ljbzMyZDR0?=
 =?utf-8?B?QXNLWjRqRGh5U3l3WDZjTStqd1o1MkMyTmQ2MTZYLzA4ZVg3L2NCdkJ5SmJl?=
 =?utf-8?B?M2FIakpyVW8zSllkZEV4SVN0ZTkvNVJFdmZBQnpTM1gzUm9QQTY0em5jN3Av?=
 =?utf-8?B?TXBFMURnZDZ4Zjk3UENRS2ZXSVJuOFYwWWtpbWFDUkJZN3Z6NVBDSTZZWDRN?=
 =?utf-8?B?MHhqVDJHY1Q3QkkyRjlBb3Rid1ZpTjVqU3dsNTVvb2wweGdFMlRMYUtJN2xk?=
 =?utf-8?B?cE1Jd2tBSGlBNVk4clQ1U3lrbGtjUE5pV2tNT0VmNU5qMmUvRWltRyswcWd1?=
 =?utf-8?B?RHgzR1BZN1BzaGR6aGJ4VStBRHZDbjlnWEVONWxEOTF2clgvZDNLNFg0bzg3?=
 =?utf-8?B?Rm1pZlR6dFg4RGJ6NnJNN2Y3R285MXJWME5DeXRPMkRpTlNBaFZjcXdWMjg1?=
 =?utf-8?B?Znk0QW45VHF3alJ3OXFOdHE3RHFYQ0tjT2lCM1ZPYjJ2YVdSL2lQOGtvVUE1?=
 =?utf-8?B?bTlTUCtDa3ZJQ3BxNTBsbm5UQzFPOE5YNWorZWpvSERxdXJZMUlLZW5uLzZJ?=
 =?utf-8?B?M3A3TlZVSm5Cb29EUjJ2V20wazg2eWFtTUFBaWxSVGRtOWsxRFFBZURmb3gx?=
 =?utf-8?B?aWxIcmxxdGF6VDFrVWRURis5UDNpT1cyNDZtUVY4eUFISnBoSDhsNFp3aXFm?=
 =?utf-8?B?R01XTkR0R0lVaG5KbnE1bEt3YTMya0ttY2hwcnp4WDVkVmNEbDRRMGlLd2Nt?=
 =?utf-8?B?NEU4czYxRXk3d0JTRTdjc3pmTURaT0tXMmpRMTIrcmdNZkN4YmlCVzU3NGNo?=
 =?utf-8?B?TFd4bTB3QUJxakZaQ3BmWTlQS202S0gyL2NnNDRvQXVLTFAzQnptMzZ0TTFh?=
 =?utf-8?B?dDE4UDA4OWxIT1FGY1QyVExDYzFqNjJqdG11a1gvS1c3NzBBeE1LWi92aGJy?=
 =?utf-8?B?UGNHYjl1T0ZiTzNqcThKYnVyODRPRkFTaWdZaFNyQU9XRHEvdGZhKzlxSWcz?=
 =?utf-8?B?djdYTWZHUUFndE95QXlpNWxOemc5Q0VEd1E3WlU1dndUbmttQnpZdnRaVUdh?=
 =?utf-8?B?RzRXNnJNK3M1M2JjYmVCbDZpdllsV0NSN3RBS3FlZE4xcThIVE1KeEE3NEpZ?=
 =?utf-8?B?RkZyWFFMeUdYWmh2R0JzaWVOWGc2RkU5SXI2RElHSDk1QmxaM1kxU0UzVGUy?=
 =?utf-8?B?WTd2Q0ZTRzB0YUdFUXUwVFNLSENKNWZJNmljUEFrTmZ3TmRzZlhvcS91OXZq?=
 =?utf-8?B?VEdrd2RtWFdwQ2haSkZZU1JqcU5BZXJCUE9ZZ3FPNThWWmNoZ0N0dCtjY25O?=
 =?utf-8?B?VlJFRlJHcTRNRmtiZ2lOa3F3ZmswRkwzdEk5RmQwOWpDWklwanR4VURXWmMr?=
 =?utf-8?B?R3ZwRzUxNTVETHM0dzFWbkJKVDBKQ1BMNFdPQURNYWYxOGxjN3RScCtDNExj?=
 =?utf-8?B?cTZVZURxd0h2VmhuVE5GNGZnZ2RXSmpiODVuOTZjZjBQVlZtSzNjU2lBR2Rv?=
 =?utf-8?B?aDFMRVJkZ2p0WnB6ZW9ndmFCaEVkM3pYcTlnaEZkUnRpR3pNZktsRENoWS9w?=
 =?utf-8?B?blRRNW40YTZLQ0tNZFA1MG53S3NMV25xZUZ0Q0thUXBWNVNtUitHY2hkTnlO?=
 =?utf-8?B?TFoybXZqTVlJaFRKaWR2Y2x3VEh2cGVVbS93MktBZnZWK1dvOXFWdWVtUllH?=
 =?utf-8?B?WHBCOHQ5VXIrd2JhSE1aRDY2QXpSRnZFb3JvZC94RWJoWmE0SU9FN3BXdGd5?=
 =?utf-8?B?bjVVR2tJYXROMzQwTXBVMTY0ejAwSnBDZU8xWUl1dXE0KzV0ZGtCT3pCZlM5?=
 =?utf-8?B?UFlRR0hTK0dXUEhHYlcrVkF5OXYrNzdMemZ3S01IcmRCNW1KZXlvbEQ3S0lk?=
 =?utf-8?B?MXduRlp0K0lSM29OL3YzTWgzd1VQUFZjUHRFUE9tb0FDREJQYjVKR0xjTDJV?=
 =?utf-8?Q?81Ty4V8ylFRnpICKKaEyN6M=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: P9RO0Uu2jIJZjUM1YO1AtaqCrg+HkBF8T1GMeqaonQ1ed53utYMj5z3Es2uBGdrxlvfaDjctw80QpBLaRpNMjwd/YJzL8KxSyA79DoiQYUrRe2r2fackW3p4YDBv8TkkMRLm2frbblEbJWUV9o0/95bQQSHBS5knf8FDUt6+9PotPphgVT0Jp64gNXinTIhbaU9BiplEH51Da6246ARv7GqfUZN5KjQI2IH900twS7WTrJL2HTmYQQKwvnRdG10l0Kw9Xbd0vVl8muGpn+e5vyJ9SFg9pa+2vEw/CzC8b7mjYf/TlSB7lKFi/F4P4IOkVCd2XCtqxdzIFPXUVO+AgxRVBVDbUCE0uQBtkWc2EnEZtQsYd1CLmzN1V5qjPJY8heUfw0HYMf/y+pSmHwRlh+B3YQdGAgzdqtujblLa7maGttS9eILp0sl859W1T1fMu6VjPckKnXqaXrBqD2j8HGgFvxABgs/mg04+Mpmvepv7TjFHkPgGawDrodCUnSUEGkPqgSDooJo/MCdu9WUhBGIfVyEdwObB63LooYXZZKqyhD6tS5jecH37YTt5Dr+Iyd1DmK7DFkgFssLMCroHVttVwaMx2ncwCb0/LP6DltUUG1EkpUzf5yuRoAgNJYW8byL6QH9wfzxxiN3W0kIQFXLRMPU5Kt2UDxLQxyfYHSybm2PfI2AnDZD0kCdZjBxl82IH7IdG2qgjcMFnqlhUEe3S7PUFqcftRtqffBkEXO/MSN6HUk9hmbc2ocTmA78xyJUpiXGS1HoAQTGPBU2jMmLO8bSKfBTOhTOL4pEEDa0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a022dab-51a8-4167-c41b-08db4bc4ac79
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2023 10:53:48.4754
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bkpsEZrRjmiGk4HpiRnKI43LW/OQ357YgVGJCwmA+zsbQMXLkHyaGIsyQDunWPg+UHE1Uk9w8j8khgUzEmGZ3xOKQviEWDU6haTbrwIWt6UdV7INMgl0u8zWAkpVx2h4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6956
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-03_06,2023-05-03_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2305030091
X-Proofpoint-GUID: lNiuj7gGsIiFlaPQrVGwdvet6NZvHtXz
X-Proofpoint-ORIG-GUID: lNiuj7gGsIiFlaPQrVGwdvet6NZvHtXz
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Christian,

On 03/05/23 12:30 pm, Christian Brauner wrote:
> On Tue, May 02, 2023 at 06:23:51PM +0000, Chuck Lever III wrote:
>>
>>
>>> On May 2, 2023, at 12:50 PM, Chuck Lever III <chuck.lever@oracle.com> wrote:
>>>
>>>
>>>
>>>> On May 2, 2023, at 9:49 AM, Chuck Lever III <chuck.lever@oracle.com> wrote:
>>>>
>>>>>
>>>>> On May 2, 2023, at 9:36 AM, Christian Brauner <brauner@kernel.org> wrote:
>>>>>
>>>>> We've aligned setgid behavior over multiple kernel releases. The details
>>>>> can be found in commit cf619f891971 ("Merge tag 'fs.ovl.setgid.v6.2' of
>>>>> git://git.kernel.org/pub/scm/linux/kernel/git/vfs/idmapping") and
>>>>> commit 426b4ca2d6a5 ("Merge tag 'fs.setgid.v6.0' of
>>>>> git://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux").
>>>>> Consistent setgid stripping behavior is now encapsulated in the
>>>>> setattr_should_drop_sgid() helper which is used by all filesystems that
>>>>> strip setgid bits outside of vfs proper. Usually ATTR_KILL_SGID is
>>>>> raised in e.g., chown_common() and is subject to the
>>>>> setattr_should_drop_sgid() check to determine whether the setgid bit can
>>>>> be retained. Since nfsd is raising ATTR_KILL_SGID unconditionally it
>>>>> will cause notify_change() to strip it even if the caller had the
>>>>> necessary privileges to retain it. Ensure that nfsd only raises
>>>>> ATR_KILL_SGID if the caller lacks the necessary privileges to retain the
>>>>> setgid bit.
>>>>>
>>>>> Without this patch the setgid stripping tests in LTP will fail:
>>>>>
>>>>>> As you can see, the problem is S_ISGID (0002000) was dropped on a
>>>>>> non-group-executable file while chown was invoked by super-user, while
>>>>>
>>>>> [...]
>>>>>
>>>>>> fchown02.c:66: TFAIL: testfile2: wrong mode permissions 0100700, expected 0102700
>>>>>
>>>>> [...]
>>>>>
>>>>>> chown02.c:57: TFAIL: testfile2: wrong mode permissions 0100700, expected 0102700
>>>>>
>>>>> With this patch all tests pass.
>>>>>
>>>>> Reported-by: Sherry Yang <sherry.yang@oracle.com>
>>>>> Signed-off-by: Christian Brauner <brauner@kernel.org>
>>>>

We had a very similar report from kernel-test-robot.

https://lore.kernel.org/all/202210091600.dbe52cbf-yujie.liu@intel.com/

Which points to commit: ed5a7047d201 ("attr: use consistent sgid 
stripping checks")

And the above commit is backported to LTS kernels -- 5.10.y,5.15.y and 
6.1.y

So would it be better to tag it to stable by adding "Cc: 
<stable@vger.kernel.org>" ?

Thanks,
Harshit

>>>> There are some similar fstests failures this fix might address.
>>>>
>>>> I've applied this patch to the nfsd-fixes tree for broader
>>>> testing.
>>>
>>> ERROR: modpost: "setattr_should_drop_sgid" [fs/nfsd/nfsd.ko] undefined!
>>>
>>> Did I apply this patch to the wrong kernel?
>>
>> setattr_should_drop_sgid() is not available to callers built as
>> modules. It needs an EXPORT_SYMBOL or _GPL.
> 
> Hey Chuck,
> 
> Thanks for taking a look!
> The required export is part of
> commit 4f704d9a835 ("nfs: use vfs setgid helper")
> which is in current mainline as of Monday this week which was part of my
> v6.4/vfs.misc PR that was merged.
> 
> So this should all work fine on mainline. Seems I didn't use --base
> which is why that info was missing.
> 
> Thanks!
> Christian
> 
> 

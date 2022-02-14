Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C48244B5617
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Feb 2022 17:25:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356326AbiBNQXp (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 14 Feb 2022 11:23:45 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237864AbiBNQXm (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 14 Feb 2022 11:23:42 -0500
Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3753460A9B
        for <linux-nfs@vger.kernel.org>; Mon, 14 Feb 2022 08:23:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1644855812;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XaIaLF3hI2R/Y4KmnvozlNXheok+GpuRXlHaH9gUgos=;
        b=bQnjLVuH9FX86htKcmno2rnU73569Ngq7bRk6WGw33bCD2jDpbPEyqnHPbtnikCQXqkPxd
        KChSbmWUP2rjt2IyYqjn465lI29Q7w616uPtq/hGZjX7+MwEWELdgeLx5do6v3HaO3RH3E
        Sv0PWxdnC6f5+siy1TY/uGuc105DPOQ=
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04lp2059.outbound.protection.outlook.com [104.47.14.59]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-9-A_51Ov5MMrGFKI9ojo0BAw-1; Mon, 14 Feb 2022 17:23:31 +0100
X-MC-Unique: A_51Ov5MMrGFKI9ojo0BAw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WcWpP6eEtXVSZ6BvzsCE839WDklkhNQ/smiI8vHctxyf5C650IWlWZYD70j4bSDPKPflbzUnLl5dWgSAf0hKqLJV+bjJvAC7xeX8TK36KsrmxZ5jc+rQ0IUTEPGvDFpwt6Ymd17qjp+zuCjTk56wJb0MRlv8WGEnNovvKgsQtyQXvmf22vspb3yq320YUi+7y5xejgqd6e+ihrdeZJwR0WzjQaKbpNbuHHAH5vYE1EXPxQP6KWzcPlnDtdB13p9VrS3O2MLd2GoBcH24tWrT4bP7RrwfnzC8ETWZf5KMTI6q3yeAtDeoDq9fXctOqXhPwH7Nsqb5kE1Mmw0Zl0w5Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DN9J5Q865mdFILMFT0chxrWpevLPOKViY8pRTbebtkg=;
 b=jXzUjC5t0U2Z5PUReVQuPqB6PlDgHrWRGA+p6wFDpk1gKWQwCPslW42/h5iy4TrNhqYinvLN3/QoMqGjhlxt7zS92vObO6ltlAzzRF8nopuvjWTAsYoa/7grB8cOfW3a7fVhfwpBY8wgFK1sHFp/1f7sMUkB1qdVfSC7eGE6mgwAeB2kyr8m7lEjBVUmb5hgj1klpoQ7B+oRgrtYxToZn6xr3gyE0CVFyc/U5ZAZuTVZG1XbWksPsXR4ynYdr7Go0fuNL5VhxoVYoQOrxzIA2gOacwGLoVM7d07ttSSqqq/MYFkKMJCerzObgS/LKYsaDFMM/3ZKMPqdh1RbEapDIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from DB6PR04MB3144.eurprd04.prod.outlook.com (2603:10a6:6:f::10) by
 AM5PR0402MB2929.eurprd04.prod.outlook.com (2603:10a6:203:9b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.15; Mon, 14 Feb
 2022 16:23:29 +0000
Received: from DB6PR04MB3144.eurprd04.prod.outlook.com
 ([fe80::46c:d35e:a7c1:3ebd]) by DB6PR04MB3144.eurprd04.prod.outlook.com
 ([fe80::46c:d35e:a7c1:3ebd%5]) with mapi id 15.20.4975.014; Mon, 14 Feb 2022
 16:23:29 +0000
Date:   Mon, 14 Feb 2022 17:23:28 +0100 (CET)
From:   Thomas Blume <tblume@suse.com>
To:     Chuck Lever III <chuck.lever@oracle.com>
cc:     libtirpc List <libtirpc-devel@lists.sourceforge.net>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [Libtirpc-devel] [PATCH] rpcb_clnt.c config to try protocolversion
 2 first
In-Reply-To: <F1A91E0B-4544-4739-ADAD-CF9FCC9E8F66@oracle.com>
Message-ID: <q7n3pnn5-6o3-524-8rn1-q7oprr139258@fhfr.pbz>
References: <20220214092607.24387-1-Thomas.Blume@suse.com> <F1A91E0B-4544-4739-ADAD-CF9FCC9E8F66@oracle.com>
Content-Type: multipart/mixed; boundary="-1593167553-383908219-1644855809=:15545"
X-ClientProxiedBy: FR3P281CA0074.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::12) To DB6PR04MB3144.eurprd04.prod.outlook.com
 (2603:10a6:6:f::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d5d0abdc-fd7e-40a0-13cb-08d9efd655c0
X-MS-TrafficTypeDiagnostic: AM5PR0402MB2929:EE_
X-Microsoft-Antispam-PRVS: <AM5PR0402MB2929079CB20146B520E9A44BF4339@AM5PR0402MB2929.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XAU0+pO6p1/JhVj9yDOSSLB7x2u/970JVz6UBlL36wqnvLffSpAGc0xgUNdkLaIY6OAAQ216sGOTvkIIwC/8Aq6bjeOWb2fZcXGahz54LCyQ5Q0RspD5M677Vy/LS9Ta6AsMz/ZR1diOVbKfQt+C/DfNrgNf7CvuuptfsMAoMEfGulaLOcCZZiiBhfse98tSrPKx9qXq6Mn/v9cJILNYCzJsD79Kc8cQYzSYVs33rMym6+KMo6UV/uF87J24vo+4Ak2n/nN/aCjM/yM/U5iPCr5Vwzx7xa1VJ+s3Kw2ZbvjAk+qnx/cds+Ps7XxQOPwHqaBoD5HbXDYW+ROOUCv3UpfqnLkWcefOs3pgIX9HNtSiAfUA5pheEk45WMNFKMAfZYjQr+PNgv9Pxs23PFIDR7s0zUwbd7722dOL0Jtkkbpd0TqV/ozZbkyvrB542MGufmsIi9f593wHSJUbsW6KpMlUQ6vCiweLWPeabpTPuDFzWlbpDrFt4ID4iIAmL2xPN5A4FBlhxq/7ycyUyabIMel9SuMtUNCWP7Rp3OhgLzMsmyRBXYtDlgEERrSPKw/d8gWkuFRP35kuEbNaXGDD20QmB8JzlRCksLBQVxrdUbykLHilkifRTSQIU3maR7DV1bINGvHZcoMzXgLEGsETElvnixbTcGgTR6khMpn5v6GPGzjxYbQCAL/3eNgZfX8EXR6VwVbVCRQ0cfCfaUtzYU49K4jH6+25xg610YopINDReMXdN7IOUxuw065V3dqYzeKz//MDcNqAUUxpeHS/6Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR04MB3144.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8936002)(5660300002)(6916009)(966005)(54906003)(316002)(6512007)(4326008)(53546011)(6506007)(8676002)(6486002)(66946007)(186003)(26005)(36756003)(38100700002)(9686003)(83380400001)(66476007)(66574015)(66556008)(2906002)(508600001)(53540200001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-15?Q?VrlQfOyKQ8oS/hKGyq+ahZXL2Mc3pATlnT/bdfUBojZ83Q5Ah59M94Wbx?=
 =?iso-8859-15?Q?B15kSrfAt3xXuiELGo2nFu2L1qovLj1Vl+LZZ3Z+xFnR0ba1126CesIss?=
 =?iso-8859-15?Q?G42OA1qAieyWGL/LPuTGq3NezgwyvdT1VDctLfWzMfte0W+4cN+iWYZPs?=
 =?iso-8859-15?Q?QUiDzl20K3+8+XOZhkQlrQZ0GFCsnZH1G/Ps60VkA9eLjJTcqTln+KJqX?=
 =?iso-8859-15?Q?Zw0BThbqub56E1M23nlOMtRFhXYGJKBcE+5KTYiUDHEtmOCrqiHuk7EcS?=
 =?iso-8859-15?Q?/DgJCpqTnpcsrtOG8iA//gAjTp2cs148HXORLYEbKdKAN7UWHcskbRYrr?=
 =?iso-8859-15?Q?5X40MPX2SRdicWOQxrylLvMvfpc+ZCf7SOjSak8MkAjBBi4H4lh0AFrJx?=
 =?iso-8859-15?Q?ikVB7jwiL5NSXiRU9/PqbhxcS2LIw5doJirF6BpqMcREJBR51CXYBEN4x?=
 =?iso-8859-15?Q?m3KWVbR7HuUY1buo6gV5eMp6+c39VN6mVDhVJfq1BxiJMvGPRYOJtf6Ly?=
 =?iso-8859-15?Q?FpJDVHlOAbA6BAAE+81Tk5oG/Dw+ZjiSfSg7hgDeHjXaAeIiSUt2jw2cO?=
 =?iso-8859-15?Q?OB2w76i0vYmG5eZ92tNVHDSjvxcabDmVwxz5Kgf7X1oGnjmLdhU7l0bTo?=
 =?iso-8859-15?Q?zeNIl5YfoxoN5vP/imGUPfmL80Ea7umUg4GOABNSKZ5NxvS91//EXYOzB?=
 =?iso-8859-15?Q?NZe4N7WxddjYC100IFqecDHSz2vIucbdB8rPzQ0FhJfa6UaPGCjocJGJF?=
 =?iso-8859-15?Q?nsUpK5JJy0E/5aQRBtnNxtNyUMhM8XjdCars5Zf8xt45s/XSumYWc46iu?=
 =?iso-8859-15?Q?l9NsNsK1MM4veq9Ju63MSvvvs2eVcoMdkPxXyRFZsoQHGbLnVbIg+ehGJ?=
 =?iso-8859-15?Q?Ec+MsVU+IVPLZLzcEKxCKT4e6PLFJOCfxATg3M+Iq3MVKNbABr2L6gul5?=
 =?iso-8859-15?Q?WudM8Zu2rx5k9iJl9VzZXIayio0+6uCeE83FLM7H9MMGI5Ubvh7JP33/n?=
 =?iso-8859-15?Q?tf20jZLEpio1RD7alczMRgMU6UV7synxLUMP+gSnC80qL6cZ4gkWJALg7?=
 =?iso-8859-15?Q?0S9ynwOXggp/atT7kjmP/l5iNSzxqNnqkA8YfkHFSGuArmDbU1mREU/8y?=
 =?iso-8859-15?Q?+wxkToySjLlz1ayPubTbQe7wwmPF7yKypYVHmjDPu648HkntsYVkvBoB5?=
 =?iso-8859-15?Q?cQls9l+gq7h8MTjUzzjRZtxW9evem4PsuxLzILulEZZpuii/ystvdLDPb?=
 =?iso-8859-15?Q?VHQqrlYGk0Om6wZSOlhtiwbPlWaZ5YxsFLnzncf66ln7fVHVSvX0OKy3i?=
 =?iso-8859-15?Q?PQkLQJIK36JR/r2FVAmzlTMPlBf8O3QhP0Tizpi/Qs9CXbQXbS8JeGrg4?=
 =?iso-8859-15?Q?O7UVTWbWD3mg85+sbDtBouOtIfF9orpb3HOWwVp2NCjxJR2hPBvIzs4na?=
 =?iso-8859-15?Q?y76fZsoEpdyexbp+o9sMrr/b7kmVPwPDahrvSLRX/Uugo0tXef776D/DW?=
 =?iso-8859-15?Q?KSAeZF6rsWXxxuo1u4keDkyMXha28R1qkeyGNOXV+D+iSeO8HRdsYZWeE?=
 =?iso-8859-15?Q?d7zKYgvEJGFvhXClUFOtrMkh/vaSs5O/1383wW79Zsr4jCQTMeRzF65c1?=
 =?iso-8859-15?Q?kl74d1QvpOKmn4n29I2jzsM2qT6ZFnkD7GaO3AutoV0FaCL1uUJF2S7vV?=
 =?iso-8859-15?Q?f22EODcsHPaywaNOOxpMKhyKMVRhi+bbArXpxiHQCgiQ3fM=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5d0abdc-fd7e-40a0-13cb-08d9efd655c0
X-MS-Exchange-CrossTenant-AuthSource: DB6PR04MB3144.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2022 16:23:29.1420
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1opE0ssIMF5DjLdP/IK5nPw2UgS50/iAAQ1yYcParqpQJNti4WPzJTRzE2NE87vU6sRq29zUXJHKtultvT4QNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0402MB2929
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

---1593167553-383908219-1644855809=:15545
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8BIT

Hello Chuck,

On Montag 2022-02-14 16:26, Chuck Lever III wrote:

>> On Feb 14, 2022, at 4:26 AM, Thomas Blume via Libtirpc-devel <libtirpc-devel@lists.sourceforge.net> wrote:
>>
>> In some setups, it is necessary to try rpc protocol version 2 first.
>
> Before applying this, I hope we can review previous discussions of
> this issue. I've forgotten the reason some users prefer it, or
> maybe I'm just imagining we've discussed it before :-)

We've had a discussion about 1 year ago:

https://sourceforge.net/p/libtirpc/mailman/message/37227894/

actually that encouraged me to send a patch, even though I initially thought
is wasn't good enough for upstream.

> The patch description, at the very least, has to have a lot more
> detail about why this change is needed. Can it provide a URL to
> threads in an email archive, for example?

This goes back to an old SUSE bugreport following the change of rpc protocol
version 2, 3, 4 to 4, 3, 2.
Below an description of issue the customer was seeing:

-->
An 3rd party NFS Server is behind a F5 front end load balancer device.
The F5 front end load balancer device is replacing IP addresses in packets as
they head to a NFS server.
It replaces IP addresses in headers but as you might expect it does not replace
the IP address within the RPC data payload, i.e. within RPC GETADDR request,
which places an address there for the universal address or hint.  Without a
correct hint, the GETADDR reply which comes back gives an unexpected address
which happens to be unroutable from the nfs client's point of view.
--<

We agreed that this is rather an issue of the loadbalancer hardware, but we
would have to address that anyway due to backward compatibility.

So, the first question is, do we want to stay backward compatible upstream?
We have to do that as distributor, but of course upstream is different.

>> Creating the file  /etc/netconfig-try-2-first will enforce this.
>
> A nicer administrative API would enable you to update the whole
> rpcbind version order, but that might be more work than you want
> to pursue.
>
> It would be a nicer if, instead of a separate file, a line is
> added to /etc/netconfig to toggle this behavior, or provide the
> whole version order. E.g.
>
> # rpcbind 4 3 2
>
> # rpcbind 2 4
>
> Really, though, this isn't related to the transport definitions
> in /etc/netconfig, so a separate configuration file might be
> more appropriate.

Thanks for the hints, if you deem a patch would be still desireable I will work
on that.


Best regards
Thomas Blume

SUSE Software Solutions Germany GmbH
Maxfeldstr. 5
90409 Nürnberg
Germany

(HRB 36809, AG Nürnberg)
Geschäftsführer: Ivo Totev
---1593167553-383908219-1644855809=:15545--

